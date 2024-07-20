using GenX
using CSV
using DataFrames
using JuMP

function tegs_case(dsratio, csratio, en_cap, cap, ch_cap, outputs_path, mysetup, myinputs, OPTIMIZER)
    dfGen = myinputs["dfGen"]
    
    START_SUBPERIODS = myinputs["START_SUBPERIODS"]
    INTERIOR_SUBPERIODS = myinputs["INTERIOR_SUBPERIODS"]
    hours_per_subperiod = myinputs["hours_per_subperiod"]
    println("Generating the Optimization Model")
    EP = generate_model(mysetup, myinputs, OPTIMIZER)

    #Code 10 - SOS2 (PL, LI)
    @expression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/en_cap)
    @expression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/en_cap)
    
    x_dis = [0.0000, 0.0195, 0.1372, 0.3671, 0.6717, 1.0000]
    y_dis = [0.0000, 0.0238, 0.3958, 0.7991, 1.0000, 1.0000]
    N = length(x_dis)
    for t in INTERIOR_SUBPERIODS
        λ1 = @variable(EP, [1:N], lower_bound = 0, upper_bound = 1)
        @constraint(EP, sum(λ1) == 1)
        @constraint(EP, λ1 in SOS2())
        @constraint(EP, EP[:SOC_interior][t] == λ1' * x_dis)
        @constraint(EP, EP[:vP][end, t] <= cap * λ1' * y_dis)
    end
    for t in START_SUBPERIODS
        λ2 = @variable(EP, [1:N], lower_bound = 0, upper_bound = 1)
        @constraint(EP, sum(λ2) == 1)
        @constraint(EP, λ2 in SOS2())
        @constraint(EP, EP[:SOC_start][t] == λ2' * x_dis)
        @constraint(EP, EP[:vP][end, t] <= cap * λ2' * y_dis)
    end

    x_ch = [0.0000, 0.0419, 0.0989, 0.6843, 0.9640, 1.000]
    y_ch = [1.0000, 0.7749, 0.6604, 0.2321, 0.0023, 0.000]
    N = length(x_ch)
    for t in INTERIOR_SUBPERIODS
        λ3 = @variable(EP, [1:N], lower_bound = 0, upper_bound = 1)
        @constraint(EP, sum(λ3) == 1)
        @constraint(EP, λ3 in SOS2())
        @constraint(EP, EP[:SOC_interior][t] == λ3' * x_ch)
        @constraint(EP, EP[:vCHARGE][end, t] <= ch_cap * λ3' * y_ch)
    end
    for t in START_SUBPERIODS
        λ4 = @variable(EP, [1:N], lower_bound = 0, upper_bound = 1)
        @constraint(EP, sum(λ4) == 1)
        @constraint(EP, λ4 in SOS2())
        @constraint(EP, EP[:SOC_start][t] == λ4' * x_ch)
        @constraint(EP, EP[:vCHARGE][end, t] <= ch_cap * λ4' * y_ch)
    end

    println("Solving Model")
    EP, solve_time = solve_model(EP, mysetup)
    myinputs["solve_time"] = solve_time # Store the model solve time in myinputs

    println("Writing Output")
    elapsed_time = @elapsed write_outputs(EP, outputs_path, mysetup, myinputs)
    println("Time elapsed for writing is")
    println(elapsed_time)

    return objective_value(EP)

end

############################################
# Some necessary helper functions
############################################
include("../RunTools.jl")

costpermwdischarge = 0.5667 * 1e6
costpermwcharge = 0.0169 * 1e6
costpermwhstor = 9.2528 * 1e3 

function annuitize(cost::Float64, lifetime::Float64, discount_rate::Float64)
    return cost * discount_rate / (1 - (1 + discount_rate)^(-lifetime))
end

function TEGS_costs(lifetime::Float64, discount_rate::Float64)
    discharge_cost = annuitize(costpermwdischarge, lifetime, discount_rate)
    storage_cost = annuitize(costpermwhstor, lifetime, discount_rate)
    charge_cost = annuitize(costpermwcharge, lifetime, discount_rate)

    costs = Dict{String, Float64}(
    "Inv_Cost_per_MWyr" => discharge_cost,
    "Fixed_OM_Cost_per_MWyr" => 0.25 * discharge_cost,
    "Inv_Cost_per_MWhyr" => storage_cost,
    "Fixed_OM_Cost_per_MWhyr" => 0.25 * storage_cost,
    "Inv_Cost_Charge_per_MWyr" => charge_cost,
    "Fixed_OM_Cost_Charge_per_MWyr" => 0.25 * charge_cost,
)
    return costs
end

function selectresource(dfGen::DataFrame, resourcename::String)
    dfgen_search = groupby(dfGen, :Resource)
    return dfgen_search[(resourcename,)]
end
    
function setTEGScosts!(dfGen::DataFrame, lifetime::Float64, discount_rate::Float64)
    TEGS_input = selectresource(dfGen, "TEGS")
    tegs_costs = TEGS_costs(lifetime, discount_rate)
    for (param, value) in tegs_costs
        TEGS_input[!,param] .= value
    end   
end

############################################
# Case Definitions 
# All cases intended to be run from the run-file directory
############################################
root_dir = dirname(dirname(dirname(@__FILE__))) # Should be ../TEGS_runs
run_name = "PL_model"

location_dir = Dict{String, String}(
    "texas" => joinpath(root_dir, "data", "texas_stor2"),
)

emissions_levels = Dict{String, Float64}(
    "0.01"=>0.01
    )

emiss_targets = Dict{String, Dict{String, Float64}}(
    "texas" => Dict{String, Float64}(),
)

for (loc_name, loc_emiss) in emiss_targets
    outputs_path = joinpath(root_dir, "outputs", loc_name, "emissions_and_baseline_v2", "baseline")
    emissions_df = DataFrame(CSV.File(joinpath(outputs_path, "emissions.csv")))
    baseline_emiss = emissions_df.Total[1]
    for (emiss_name, emiss_level) in emissions_levels
        loc_emiss[emiss_name] = baseline_emiss * emiss_level
    end
end
        
lossrate = 3

for (loc_name, loc_path) in location_dir
    case = loc_path
    genx_settings = get_settings_path(case, "genx_settings.yml") #Settings YAML file path
    mysetup = configure_settings(genx_settings) # mysetup dictionary stores settings and GenX-specific parameters

    mysetup["CO2Cap"] = 1

    scale_factor = mysetup["ParameterScale"] == 1 ? ModelScalingFactor : 1

    inputs_path = case
    settings_path = get_settings_path(case)

    outputs_path_root = joinpath(root_dir, "outputs", loc_name, run_name)
    if !isdir(outputs_path_root)
        mkpath(outputs_path_root)
    end

    ### Configure solver
    println("Configuring Solver")
    OPTIMIZER = configure_solver(mysetup["Solver"], settings_path)

    ### Load inputs
    println("Loading Inputs")
    myinputs = load_inputs(mysetup, case)

    LIFETIME = 30.
    DISCOUNT_RATE = 0.05
    
    #### Running a case
    for (emiss_name, emiss_target) in emiss_targets[loc_name]
        myinputs["dfMaxCO2"] = emiss_target *1e3 / scale_factor
        setTEGScosts!(myinputs["dfGen"], LIFETIME, DISCOUNT_RATE)
        TEGS_input = selectresource(myinputs["dfGen"], "TEGS")
        TEGS_input[!, "Self_Disch"] .= lossrate / 100 / 24. # Convert daily loss rate to hourly
        TEGS_input[!, "STOR"] .= 2

	# Define TEGS inputs
	tau_dis = 10
	tau_ch = 1
	dsratio = tau_dis/0.5
	csratio = 0.99*tau_ch
    en_cap = 104578;
    cap = en_cap/dsratio;
    ch_cap = en_cap/csratio;
	outputs_path = joinpath(outputs_path_root, "tau_dis-$(tau_dis)_tau_ch-$(tau_ch)")
        y = tegs_case(dsratio, csratio, en_cap, cap, ch_cap, outputs_path, mysetup, myinputs, OPTIMIZER)
    end
end
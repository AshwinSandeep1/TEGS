using GenX
using CSV
using DataFrames
using JuMP

function tegs_case(outputs_path, mysetup, myinputs, OPTIMIZER)

    println("Generating the Optimization Model")
    EP = generate_model(mysetup, myinputs, OPTIMIZER)

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
println(charge_cost)
println(0.25*charge_cost)
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
run_name = "base_model"

location_dir = Dict{String, String}(
    "texas" => joinpath(root_dir, "data", "texas_stor2"),
    "newEngland" => joinpath(root_dir, "data", "newEngland_stor2_v2"),
)

emissions_levels = Dict{String, Float64}(
    "0.01"=>0.01
    )

emiss_targets = Dict{String, Dict{String, Float64}}(
    "texas" => Dict{String, Float64}(),
    "newEngland" => Dict{String, Float64}(),
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

    ## Cluster time series inputs if necessary and if specified by the user
    TDRpath = joinpath(case, mysetup["TimeDomainReductionFolder"])

    if mysetup["TimeDomainReduction"] == 1
        if !time_domain_reduced_files_exist(TDRpath)
            println("Clustering Time Series Data (Grouped)...")
            cluster_inputs(inputs_path, settings_path, mysetup)
        else
            println("Time Series Data Already Clustered.")
        end
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
	outputs_path = joinpath(outputs_path_root, "temp-2400_lossrate-$(lossrate)")
        y = tegs_case(outputs_path, mysetup, myinputs, OPTIMIZER)
    end
end

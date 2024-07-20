    
    #Code 1 - @NLexpression + @NLcontraint (PL, NL)
    @constraint(EP, TEGSdsratio, EP[:eTotalCap][end] * dsratio == EP[:eTotalCapEnergy][end])
    @constraint(EP, TEGScsratio, EP[:eTotalCapCharge][end] * csratio == EP[:eTotalCapEnergy][end])

    @NLexpression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/EP[:eTotalCapEnergy][end])
    @NLexpression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/EP[:eTotalCapEnergy][end])
    
    @expression(EP, sub_t, t in INTERIOR_SUBPERIODS)

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], 
    ifelse(EP[:SOC_interior][t] >= 0.6717, EP[:vP][end,t] <= EP[:eTotalCap][end],
    ifelse(EP[:SOC_interior][t] < 0.6717 && EP[:SOC_interior][t] >= 0.3671,EP[:vP][end,t] <= EP[:eTotalCap][end]*(0.6564 * EP[:SOC_interior][t] + 0.5582),
    ifelse(EP[:SOC_interior][t] < 0.3671 && EP[:SOC_interior][t] >= 0.1372,EP[:vP][end,t] <= EP[:eTotalCap][end]*(1.7581 * EP[:SOC_interior][t] + 0.1546),
    ifelse(EP[:SOC_interior][t] < 0.1372 && EP[:SOC_interior][t] >= 0.0195,EP[:vP][end,t] <= EP[:eTotalCap][end]*(3.1561 * EP[:SOC_interior][t] - 0.0379),
    EP[:vP][end,t] == 0))))>=1)

    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], 
    ifelse(EP[:SOC_start][t] >= 0.6717, EP[:vP][end,t] <= EP[:eTotalCap][end],
    ifelse(EP[:SOC_start][t] < 0.6717 && EP[:SOC_start][t] >= 0.3671,EP[:vP][end,t] <= EP[:eTotalCap][end]*(0.6564 * EP[:SOC_start][t] + 0.5582),
    ifelse(EP[:SOC_start][t] < 0.3671 && EP[:SOC_start][t] >= 0.1372,EP[:vP][end,t] <= EP[:eTotalCap][end]*(1.7581 * EP[:SOC_start][t] + 0.1546),
    ifelse(EP[:SOC_start][t] < 0.1372 && EP[:SOC_start][t] >= 0.0195,EP[:vP][end,t] <= EP[:eTotalCap][end]*(3.1561 * EP[:SOC_start][t] - 0.0379),
    EP[:vP][end,t] == 0))))>=1)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], 
    ifelse(EP[:SOC_interior][t] <= 0.0419, EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end]*(-5.5588*(EP[:SOC_interior][t])+1.0076),
    ifelse(EP[:SOC_interior][t] <= 0.0989 && EP[:SOC_interior][t] > 0.0419,EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end]*(-1.9383*(EP[:SOC_interior][t])+0.8522),
    ifelse(EP[:SOC_interior][t] <= 0.6843 && EP[:SOC_interior][t] > 0.0989,EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end]*(-0.7311*(EP[:SOC_interior][t])+0.7324),
    ifelse(EP[:SOC_interior][t] <= 0.9640 && EP[:SOC_interior][t] > 0.6843,EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end]*(-0.8220*(EP[:SOC_interior][t])+0.7947),
    EP[:vCHARGE][end,t] == 0))))>=1)

    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], 
    ifelse(EP[:SOC_start][t] <= 0.0419, EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end]*(-5.5588*(EP[:SOC_start][t])+1.0076),
    ifelse(EP[:SOC_start][t] <= 0.0989 && EP[:SOC_start][t] > 0.0419,EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end]*(-1.9383*(EP[:SOC_start][t])+0.8522),
    ifelse(EP[:SOC_start][t] <= 0.6843 && EP[:SOC_start][t] > 0.0989,EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end]*(-0.7311*(EP[:SOC_start][t])+0.7324),
    ifelse(EP[:SOC_start][t] <= 0.9640 && EP[:SOC_start][t] > 0.6843,EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end]*(-0.8220*(EP[:SOC_start][t])+0.7947),
    EP[:vCHARGE][end,t] == 0))))>=1)

    #Code 2 - @NLexpression + @NLconstraint w/ new syntax (PL, NL)
    @constraint(EP, TEGSdsratio, EP[:eTotalCap][end] * dsratio == EP[:eTotalCapEnergy][end])
    @constraint(EP, TEGScsratio, EP[:eTotalCapCharge][end] * csratio == EP[:eTotalCapEnergy][end])

    @NLexpression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/EP[:eTotalCapEnergy][end])
    @NLexpression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/EP[:eTotalCapEnergy][end])

    @NLconstraint(
        EP,
        TEGSeffpower_interior[t in INTERIOR_SUBPERIODS],
        EP[:vP][end,t] <= EP[:eTotalCap][end] * ifelse(
            EP[:SOC_interior][t] >= 0.6717,
            1,
            ifelse(
                EP[:SOC_interior][t] < 0.6717 && EP[:SOC_interior][t] >= 0.3671,
                0.6564 * EP[:SOC_interior][t] + 0.5582,
                ifelse(
                    EP[:SOC_interior][t] < 0.3671 && EP[:SOC_interior][t] >= 0.1372,
                    1.7581 * EP[:SOC_interior][t] + 0.1546,
                    ifelse(
                        EP[:SOC_interior][t] < 0.1372 && EP[:SOC_interior][t] >= 0.0195,
                        3.1561 * EP[:SOC_interior][t] - 0.0379,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @NLconstraint(
        EP,
        TEGSeffpower_start[t in START_SUBPERIODS],
        EP[:vP][end,t] <= EP[:eTotalCap][end] * ifelse(
            EP[:SOC_start][t] >= 0.6717,
            1,
            ifelse(
                EP[:SOC_start][t] < 0.6717 && EP[:SOC_start][t] >= 0.3671,
                0.6564 * EP[:SOC_start][t] + 0.5582,
                ifelse(
                    EP[:SOC_start][t] < 0.3671 && EP[:SOC_start][t] >= 0.1372,
                    1.7581 * EP[:SOC_start][t] + 0.1546,
                    ifelse(
                        EP[:SOC_start][t] < 0.1372 && EP[:SOC_start][t] >= 0.0195,
                        3.1561 * EP[:SOC_start][t] - 0.0379,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @NLconstraint(
        EP,
        TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS],
        EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] * ifelse(
            EP[:SOC_interior][t] <= 0.0419,
            -5.5588*(EP[:SOC_interior][t])+1.0076,
            ifelse(
                EP[:SOC_interior][t] <= 0.0989 && EP[:SOC_interior][t] > 0.0419,
                -1.9383*(EP[:SOC_interior][t])+0.8522,
                ifelse(
                    EP[:SOC_interior][t] <= 0.6843 && EP[:SOC_interior][t] > 0.0989,
                    -0.7311*(EP[:SOC_interior][t])+0.7324,
                    ifelse(
                        EP[:SOC_interior][t] <= 0.9640 && EP[:SOC_interior][t] > 0.6843,
                        -0.8220*(EP[:SOC_interior][t])+0.7947,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @NLconstraint(
        EP,
        TEGSeffcharge_start[t in START_SUBPERIODS],
        EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] * ifelse(
            EP[:SOC_start][t] <= 0.0419,
            -5.5588*(EP[:SOC_start][t])+1.0076,
            ifelse(
                EP[:SOC_start][t] <= 0.0989 && EP[:SOC_start][t] > 0.0419,
                -1.9383*(EP[:SOC_start][t])+0.8522,
                ifelse(
                    EP[:SOC_start][t] <= 0.6843 && EP[:SOC_start][t] > 0.0989,
                    -0.7311*(EP[:SOC_start][t])+0.7324,
                    ifelse(
                        EP[:SOC_start][t] <= 0.9640 && EP[:SOC_start][t] > 0.6843,
                        -0.8220*(EP[:SOC_start][t])+0.7947,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    #Code 3 - @NLexpression + @NLconstraint + interp (LI)
    @constraint(EP, TEGSdsratio, EP[:eTotalCap][end] * dsratio == EP[:eTotalCapEnergy][end])
    @constraint(EP, TEGScsratio, EP[:eTotalCapCharge][end] * csratio == EP[:eTotalCapEnergy][end])

    discharge_df = DataFrame(CSV.File(joinpath(dirname(dirname(dirname(@__FILE__))),"data","fitting_data","discharge_tau10_ff1.csv")))
    push!(discharge_df,(0.0,0.0))
    discharge_df = reverse(discharge_df)
    push!(discharge_df,(1.0,1.0))

    charge_df = DataFrame(CSV.File(joinpath(dirname(dirname(dirname(@__FILE__))),"data","fitting_data","charge_tau1_ff1.csv")))
    push!(charge_df,(1.0,0.0))
    charge_df = reverse(charge_df)
    push!(charge_df,(0.0,1.0)) #Second element changes based on data file
    charge_df = reverse(charge_df)

    @NLexpression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/EP[:eTotalCapEnergy][end])
    @NLexpression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/EP[:eTotalCapEnergy][end])

    function interp_func_dis(SOC)
        interp_linear_dis = linear_interpolation(discharge_df[:,1], discharge_df[:,2])
        return interp_linear_dis(SOC)
    end
    register(EP, :interp_func_dis, 1, interp_func_dis; autodiff = true)

    function interp_func_ch(SOC)
        interp_linear_ch = linear_interpolation(charge_df[:,1], charge_df[:,2])
        return interp_linear_ch(SOC)
    end
    register(EP, :interp_func_ch, 1, interp_func_ch; autodiff = true)

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * interp_func_dis(EP[:SOC_interior][t]))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * interp_func_dis(EP[:SOC_start][t]))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] * interp_func_ch(EP[:SOC_interior][t]))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] * interp_func_ch(EP[:SOC_start][t]))

    #Code 4 - @NLexpression + @NLconstraint + interp (PL)
    @constraint(EP, TEGSdsratio, EP[:eTotalCap][end] * dsratio == EP[:eTotalCapEnergy][end])
    @constraint(EP, TEGScsratio, EP[:eTotalCapCharge][end] * csratio == EP[:eTotalCapEnergy][end])

    x_dis = [0.0000, 0.0195, 0.1372, 0.3671, 0.6717, 1.0000]
    y_dis = [0.0000, 0.0238, 0.3958, 0.7991, 1.0000, 1.0000]

    x_ch = [0.0000, 0.0419, 0.0989, 0.6843, 0.9640, 1.000]
    y_ch = [1.0000, 0.7749, 0.6604, 0.2321, 0.0023, 0.000]

    @NLexpression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/EP[:eTotalCapEnergy][end])
    @NLexpression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/EP[:eTotalCapEnergy][end])

    function interp_func_dis(SOC)
        interp_linear_dis = linear_interpolation(x_dis, y_dis)
        return interp_linear_dis(SOC)
    end
    register(EP, :interp_func_dis, 1, interp_func_dis; autodiff = true)

    function interp_func_ch(SOC)
        interp_linear_ch = linear_interpolation(x_ch, y_ch)
        return interp_linear_ch(SOC)
    end
    register(EP, :interp_func_ch, 1, interp_func_ch; autodiff = true)

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * interp_func_dis(EP[:SOC_interior][t]))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * interp_func_dis(EP[:SOC_start][t]))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] * interp_func_ch(EP[:SOC_interior][t]))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] * interp_func_ch(EP[:SOC_start][t]))
     
    #Code 5 - @expression + @constraint (PL, NL)
    @expression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/en_cap)
    @expression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/en_cap)

    @constraint(
        EP,
        TEGSeffpower_interior[t in INTERIOR_SUBPERIODS],
        EP[:vP][end,t] <= cap * ifelse(
            EP[:SOC_interior][t] >= 0.6717,
            1,
            ifelse(
                EP[:SOC_interior][t] < 0.6717 && EP[:SOC_interior][t] >= 0.3671,
                0.6564 * EP[:SOC_interior][t] + 0.5582,
                ifelse(
                    EP[:SOC_interior][t] < 0.3671 && EP[:SOC_interior][t] >= 0.1372,
                    1.7581 * EP[:SOC_interior][t] + 0.1546,
                    ifelse(
                        EP[:SOC_interior][t] < 0.1372 && EP[:SOC_interior][t] >= 0.0195,
                        3.1561 * EP[:SOC_interior][t] - 0.0379,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @constraint(
        EP,
        TEGSeffpower_start[t in START_SUBPERIODS],
        EP[:vP][end,t] <= cap * ifelse(
            EP[:SOC_start][t] >= 0.6717,
            1,
            ifelse(
                EP[:SOC_start][t] < 0.6717 && EP[:SOC_start][t] >= 0.3671,
                0.6564 * EP[:SOC_start][t] + 0.5582,
                ifelse(
                    EP[:SOC_start][t] < 0.3671 && EP[:SOC_start][t] >= 0.1372,
                    1.7581 * EP[:SOC_start][t] + 0.1546,
                    ifelse(
                        EP[:SOC_start][t] < 0.1372 && EP[:SOC_start][t] >= 0.0195,
                        3.1561 * EP[:SOC_start][t] - 0.0379,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @constraint(
        EP,
        TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS],
        EP[:vCHARGE][end,t] <= ch_cap * ifelse(
            EP[:SOC_interior][t] <= 0.0419,
            -5.5588*(EP[:SOC_interior][t])+1.0076,
            ifelse(
                EP[:SOC_interior][t] <= 0.0989 && EP[:SOC_interior][t] > 0.0419,
                -1.9383*(EP[:SOC_interior][t])+0.8522,
                ifelse(
                    EP[:SOC_interior][t] <= 0.6843 && EP[:SOC_interior][t] > 0.0989,
                    -0.7311*(EP[:SOC_interior][t])+0.7324,
                    ifelse(
                        EP[:SOC_interior][t] <= 0.9640 && EP[:SOC_interior][t] > 0.6843,
                        -0.8220*(EP[:SOC_interior][t])+0.7947,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @constraint(
        EP,
        TEGSeffcharge_start[t in START_SUBPERIODS],
        EP[:vCHARGE][end,t] <= ch_cap * ifelse(
            EP[:SOC_start][t] <= 0.0419,
            -5.5588*(EP[:SOC_start][t])+1.0076,
            ifelse(
                EP[:SOC_start][t] <= 0.0989 && EP[:SOC_start][t] > 0.0419,
                -1.9383*(EP[:SOC_start][t])+0.8522,
                ifelse(
                    EP[:SOC_start][t] <= 0.6843 && EP[:SOC_start][t] > 0.0989,
                    -0.7311*(EP[:SOC_start][t])+0.7324,
                    ifelse(
                        EP[:SOC_start][t] <= 0.9640 && EP[:SOC_start][t] > 0.6843,
                        -0.8220*(EP[:SOC_start][t])+0.7947,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    #Code 6 - @expression + @constraint + interp (LI)
    discharge_df = DataFrame(CSV.File(joinpath(dirname(dirname(dirname(@__FILE__))),"data","fitting_data","discharge_tau10_ff1.csv")))
    push!(discharge_df,(0.0,0.0))
    discharge_df = reverse(discharge_df)
    push!(discharge_df,(1.0,1.0))

    charge_df = DataFrame(CSV.File(joinpath(dirname(dirname(dirname(@__FILE__))),"data","fitting_data","charge_tau1_ff1.csv")))
    push!(charge_df,(1.0,0.0))
    charge_df = reverse(charge_df)
    push!(charge_df,(0.0,1.0)) #Second element changes based on data file
    charge_df = reverse(charge_df)

    @expression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/en_cap)
    @expression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/en_cap)

    function interp_func_dis(SOC)
        interp_linear_dis = linear_interpolation(discharge_df[:,1], discharge_df[:,2])
        return interp_linear_dis(SOC)
    end
    register(EP, :interp_func_dis, 1, interp_func_dis; autodiff = true)

    function interp_func_ch(SOC)
        interp_linear_ch = linear_interpolation(charge_df[:,1], charge_df[:,2])
        return interp_linear_ch(SOC)
    end
    register(EP, :interp_func_ch, 1, interp_func_ch; autodiff = true)

    @constraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= cap * interp_func_dis(EP[:SOC_interior][t]))
    @constraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= cap * interp_func_dis(EP[:SOC_start][t]))

    @constraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= ch_cap * interp_func_ch(EP[:SOC_interior][t]))
    @constraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= ch_cap * interp_func_ch(EP[:SOC_start][t]))

    #Code 7 - @expression + @NLconstraint (PL, NL)
    @expression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/en_cap)
    @expression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/en_cap)

    @NLconstraint(
        EP,
        TEGSeffpower_interior[t in INTERIOR_SUBPERIODS],
        EP[:vP][end,t] <= cap * ifelse(
            EP[:SOC_interior][t] >= 0.6717,
            1,
            ifelse(
                EP[:SOC_interior][t] < 0.6717 && EP[:SOC_interior][t] >= 0.3671,
                0.6564 * EP[:SOC_interior][t] + 0.5582,
                ifelse(
                    EP[:SOC_interior][t] < 0.3671 && EP[:SOC_interior][t] >= 0.1372,
                    1.7581 * EP[:SOC_interior][t] + 0.1546,
                    ifelse(
                        EP[:SOC_interior][t] < 0.1372 && EP[:SOC_interior][t] >= 0.0195,
                        3.1561 * EP[:SOC_interior][t] - 0.0379,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @NLconstraint(
        EP,
        TEGSeffpower_start[t in START_SUBPERIODS],
        EP[:vP][end,t] <= cap * ifelse(
            EP[:SOC_start][t] >= 0.6717,
            1,
            ifelse(
                EP[:SOC_start][t] < 0.6717 && EP[:SOC_start][t] >= 0.3671,
                0.6564 * EP[:SOC_start][t] + 0.5582,
                ifelse(
                    EP[:SOC_start][t] < 0.3671 && EP[:SOC_start][t] >= 0.1372,
                    1.7581 * EP[:SOC_start][t] + 0.1546,
                    ifelse(
                        EP[:SOC_start][t] < 0.1372 && EP[:SOC_start][t] >= 0.0195,
                        3.1561 * EP[:SOC_start][t] - 0.0379,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @NLconstraint(
        EP,
        TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS],
        EP[:vCHARGE][end,t] <= ch_cap * ifelse(
            EP[:SOC_interior][t] <= 0.0419,
            -5.5588*(EP[:SOC_interior][t])+1.0076,
            ifelse(
                EP[:SOC_interior][t] <= 0.0989 && EP[:SOC_interior][t] > 0.0419,
                -1.9383*(EP[:SOC_interior][t])+0.8522,
                ifelse(
                    EP[:SOC_interior][t] <= 0.6843 && EP[:SOC_interior][t] > 0.0989,
                    -0.7311*(EP[:SOC_interior][t])+0.7324,
                    ifelse(
                        EP[:SOC_interior][t] <= 0.9640 && EP[:SOC_interior][t] > 0.6843,
                        -0.8220*(EP[:SOC_interior][t])+0.7947,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    @NLconstraint(
        EP,
        TEGSeffcharge_start[t in START_SUBPERIODS],
        EP[:vCHARGE][end,t] <= ch_cap * ifelse(
            EP[:SOC_start][t] <= 0.0419,
            -5.5588*(EP[:SOC_start][t])+1.0076,
            ifelse(
                EP[:SOC_start][t] <= 0.0989 && EP[:SOC_start][t] > 0.0419,
                -1.9383*(EP[:SOC_start][t])+0.8522,
                ifelse(
                    EP[:SOC_start][t] <= 0.6843 && EP[:SOC_start][t] > 0.0989,
                    -0.7311*(EP[:SOC_start][t])+0.7324,
                    ifelse(
                        EP[:SOC_start][t] <= 0.9640 && EP[:SOC_start][t] > 0.6843,
                        -0.8220*(EP[:SOC_start][t])+0.7947,
                        0.0,
                    ),
                ),
            ),
        ),
    )

    #Code 8 - @expression + @NLconstraint + interp (LI)
    discharge_df = DataFrame(CSV.File(joinpath(dirname(dirname(dirname(@__FILE__))),"data","fitting_data","discharge_tau10_ff1.csv")))
    push!(discharge_df,(0.0,0.0))
    discharge_df = reverse(discharge_df)
    push!(discharge_df,(1.0,1.0))

    charge_df = DataFrame(CSV.File(joinpath(dirname(dirname(dirname(@__FILE__))),"data","fitting_data","charge_tau1_ff1.csv")))
    push!(charge_df,(1.0,0.0))
    charge_df = reverse(charge_df)
    push!(charge_df,(0.0,1.0)) #Second element changes based on data file
    charge_df = reverse(charge_df)

    @expression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/en_cap)
    @expression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/en_cap)

    function interp_func_dis(SOC)
        interp_linear_dis = linear_interpolation(discharge_df[:,1], discharge_df[:,2])
        return interp_linear_dis(SOC)
    end
    register(EP, :interp_func_dis, 1, interp_func_dis; autodiff = true)

    function interp_func_ch(SOC)
        interp_linear_ch = linear_interpolation(charge_df[:,1], charge_df[:,2])
        return interp_linear_ch(SOC)
    end
    register(EP, :interp_func_ch, 1, interp_func_ch; autodiff = true)

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= cap * interp_func_dis(EP[:SOC_interior][t]))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= cap * interp_func_dis(EP[:SOC_start][t]))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= ch_cap * interp_func_ch(EP[:SOC_interior][t]))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= ch_cap * interp_func_ch(EP[:SOC_start][t]))

    #Code 9 - @NLexpression+ @NL constraint + epigraph (PL, LI - convex only)
    @constraint(EP, TEGSdsratio, EP[:eTotalCap][end] * dsratio == EP[:eTotalCapEnergy][end])
    @constraint(EP, TEGScsratio, EP[:eTotalCapCharge][end] * csratio == EP[:eTotalCapEnergy][end])

    @NLexpression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/EP[:eTotalCapEnergy][end])
    @NLexpression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/EP[:eTotalCapEnergy][end])

    @NLconstraint(EP, TEGSeffpower_interior1[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end])
    @NLconstraint(EP, TEGSeffpower_interior2[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * (0.6564 * EP[:SOC_interior][t] + 0.5582))
    @NLconstraint(EP, TEGSeffpower_interior3[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * (1.7581 * EP[:SOC_interior][t] + 0.1546))
    @NLconstraint(EP, TEGSeffpower_interior4[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * (3.1561 * EP[:SOC_interior][t] - 0.0379))

    @NLconstraint(EP, TEGSeffpower_start1[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end])
    @NLconstraint(EP, TEGSeffpower_start2[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * (0.6564 * EP[:SOC_start][t] + 0.5582))
    @NLconstraint(EP, TEGSeffpower_start3[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * (1.7581 * EP[:SOC_start][t] + 0.1546))
    @NLconstraint(EP, TEGSeffpower_start4[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] * (3.1561 * EP[:SOC_start][t] - 0.0379))

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

    #Code 11 - @NLexpression + @NLconstraint + Low RMSE (NL)
    @constraint(EP, TEGSdsratio, EP[:eTotalCap][end] * dsratio == EP[:eTotalCapEnergy][end])
    @constraint(EP, TEGScsratio, EP[:eTotalCapCharge][end] * csratio == EP[:eTotalCapEnergy][end])

    @NLexpression(EP, SOC_interior[t in INTERIOR_SUBPERIODS], EP[:vS][end,t-1]/EP[:eTotalCapEnergy][end])
    @NLexpression(EP, SOC_start[t in START_SUBPERIODS], EP[:vS][end,t+hours_per_subperiod-1]/EP[:eTotalCapEnergy][end])

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4148*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4148*EP[:SOC_start][t]+0.3822)-0.6622))


    ###########################################################################################################################

    #Code for discharge analysis

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 1, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 1
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 2: tau_dis = 10, tau_ch = 1, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 1
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 3: tau_dis = 10, tau_ch = 1, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 1
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 4: tau_dis = 10, tau_ch = 1, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 1
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7423 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 5: tau_dis = 10, tau_ch = 1, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 1
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7696 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 6: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 7: tau_dis = 100, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 8: tau_dis = 100, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 9: tau_dis = 100, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7340 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 10: tau_dis = 100, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7607 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 11: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 12: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 13: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 14: tau_dis = 10, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7423 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 15: tau_dis = 10, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7696 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 16: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 17: tau_dis = 100, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 18: tau_dis = 100, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 19: tau_dis = 100, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7340 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 20: tau_dis = 100, tau_ch = 50, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7607 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 21: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 22: tau_dis = 10, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 23: tau_dis = 10, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 24: tau_dis = 10, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7423 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 25: tau_dis = 10, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7696 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))
    
    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 26: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 27: tau_dis = 100, tau_ch = 100, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 28: tau_dis = 100, tau_ch = 100, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 29: tau_dis = 100, tau_ch = 100, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7340 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 30: tau_dis = 100, tau_ch = 100, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7607 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))


    #Sim 31: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 32: tau_dis = 10, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 33: tau_dis = 10, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 34: tau_dis = 10, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7423 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 35: tau_dis = 10, tau_ch = 50, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7696 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    ###########################################################################################################################

    #Code for charge analysis

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 1, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 1
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 2: tau_dis = 10, tau_ch = 1, ff_dis = 1, ff_ch = 5
    tau_dis = 10
	tau_ch = 1
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-58.0793*EP[:SOC_interior][t]+1.4071)-1.1618*EP[:SOC_interior][t]+1.1200))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-58.0793*EP[:SOC_start][t]+1.4071)-1.1618*EP[:SOC_start][t]+1.1200))

    #Sim 3: tau_dis = 10, tau_ch = 1, ff_dis = 1, ff_ch = 10
    tau_dis = 10
	tau_ch = 1
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-90.1601*EP[:SOC_interior][t]+2.2446)-1.2276*EP[:SOC_interior][t]+1.1891))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-90.1601*EP[:SOC_start][t]+2.2446)-1.2276*EP[:SOC_start][t]+1.1891))

    #Sim 4: tau_dis = 10, tau_ch = 1, ff_dis = 1, ff_ch = 20
    tau_dis = 10
	tau_ch = 1
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-109.9569*EP[:SOC_interior][t]+3.0467)-1.0794*EP[:SOC_interior][t]+1.0995))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-109.9569*EP[:SOC_start][t]+3.0467)-1.0794*EP[:SOC_start][t]+1.0995))

    #Sim 5: tau_dis = 10, tau_ch = 1, ff_dis = 1, ff_ch = 50
    tau_dis = 10
	tau_ch = 1
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-142.9845*EP[:SOC_interior][t]+3.9914)-0.4020*EP[:SOC_interior][t]+0.6211))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-142.9845*EP[:SOC_start][t]+3.9914)-0.4020*EP[:SOC_start][t]+0.6211))

    #Sim 6: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))


    #Sim 7: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 5
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-2.6700*EP[:SOC_interior][t]^3+2.8685*EP[:SOC_interior][t]^2-5.4260*EP[:SOC_interior][t]+4.9894))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-2.6700*EP[:SOC_start][t]^3+2.8685*EP[:SOC_start][t]^2-5.4260*EP[:SOC_start][t]+4.9894))


    #Sim 8: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 10
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.3801*EP[:SOC_interior][t]+0.9702)-7.6346*EP[:SOC_interior][t]+7.4683))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.3801*EP[:SOC_start][t]+0.9702)-7.6346*EP[:SOC_start][t]+7.4683))


    #Sim 9: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 20
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.9793*EP[:SOC_interior][t]+2.4107)-9.5968*EP[:SOC_interior][t]+9.4089))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.9793*EP[:SOC_start][t]+2.4107)-9.5968*EP[:SOC_start][t]+9.4089))


    #Sim 10: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 50
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-58.4568*EP[:SOC_interior][t]+3.7075)-11.5174*EP[:SOC_interior][t]+11.3008))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-58.4568*EP[:SOC_start][t]+3.7075)-11.5174*EP[:SOC_start][t]+11.3008))


    #Sim 11: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 12: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 5
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_interior][t]+0.2686)-3.8333*EP[:SOC_interior][t]+3.7409))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_start][t]+0.2686)-3.8333*EP[:SOC_start][t]+3.7409))

    #Sim 13: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 10
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_interior][t]+1.7055)-4.8375*EP[:SOC_interior][t]+4.7091))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_start][t]+1.7055)-4.8375*EP[:SOC_start][t]+4.7091))

    #Sim 14: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 20
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_interior][t]+2.7430)-5.5969*EP[:SOC_interior][t]+5.4495))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_start][t]+2.7430)-5.5969*EP[:SOC_start][t]+5.4495))

    #Sim 15: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 50
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_interior][t]+3.8545)-5.8732*EP[:SOC_interior][t]+5.7950))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_start][t]+3.8545)-5.8732*EP[:SOC_start][t]+5.7950))

    #Sim 16: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 17: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 5
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 18: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 10
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 19: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 20
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 20: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 50
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 21: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 22: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 5
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-2.6700*EP[:SOC_interior][t]^3+2.8685*EP[:SOC_interior][t]^2-5.4260*EP[:SOC_interior][t]+4.9894))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-2.6700*EP[:SOC_start][t]^3+2.8685*EP[:SOC_start][t]^2-5.4260*EP[:SOC_start][t]+4.9894))

    #Sim 23: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 10
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.3801*EP[:SOC_interior][t]+0.9702)-7.6346*EP[:SOC_interior][t]+7.4683))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.3801*EP[:SOC_start][t]+0.9702)-7.6346*EP[:SOC_start][t]+7.4683))

    #Sim 24: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 20
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.9793*EP[:SOC_interior][t]+2.4107)-9.5968*EP[:SOC_interior][t]+9.4089))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.9793*EP[:SOC_start][t]+2.4107)-9.5968*EP[:SOC_start][t]+9.4089))

    #Sim 25: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 50
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-58.4568*EP[:SOC_interior][t]+3.7075)-11.5174*EP[:SOC_interior][t]+11.3008))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-58.4568*EP[:SOC_start][t]+3.7075)-11.5174*EP[:SOC_start][t]+11.3008))

    #Sim 26: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 27: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 5
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_interior][t]+3.7528)-17.3674))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_start][t]+3.7528)-17.3674))

    #Sim 28: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 10
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_interior][t]-2.8894)-17.5915))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_start][t]-2.8894)-17.5915))

    #Sim 29: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 20
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_interior][t]+2.0954)-31.8735))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_start][t]+2.0954)-31.8735))

    #Sim 30: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 50
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_interior][t]^3+56.2328*EP[:SOC_interior][t]^2-62.0980*EP[:SOC_interior][t]+49.9892))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_start][t]^3+56.2328*EP[:SOC_start][t]^2-62.0980*EP[:SOC_start][t]+49.9892))

    #Sim 31: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 32: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 5
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 33: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 10
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 34: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 20
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 35: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 50
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    ###########################################################################################################################

    #Code for combination analysis (TX3, NE3)

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 2: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 5
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_interior][t]+0.2686)-3.8333*EP[:SOC_interior][t]+3.7409))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_start][t]+0.2686)-3.8333*EP[:SOC_start][t]+3.7409))

    #Sim 3: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 10
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_interior][t]+1.7055)-4.8375*EP[:SOC_interior][t]+4.7091))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_start][t]+1.7055)-4.8375*EP[:SOC_start][t]+4.7091))

    #Sim 4: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 20
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_interior][t]+2.7430)-5.5969*EP[:SOC_interior][t]+5.4495))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_start][t]+2.7430)-5.5969*EP[:SOC_start][t]+5.4495))

    #Sim 5: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 50
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_interior][t]+3.8545)-5.8732*EP[:SOC_interior][t]+5.7950))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_start][t]+3.8545)-5.8732*EP[:SOC_start][t]+5.7950))

    #Sim 6: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 7: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 5
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 5

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_interior][t]+0.2686)-3.8333*EP[:SOC_interior][t]+3.7409))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_start][t]+0.2686)-3.8333*EP[:SOC_start][t]+3.7409))

    #Sim 8: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 10
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 10

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_interior][t]+1.7055)-4.8375*EP[:SOC_interior][t]+4.7091))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_start][t]+1.7055)-4.8375*EP[:SOC_start][t]+4.7091))

    #Sim 9: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 20
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 20

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_interior][t]+2.7430)-5.5969*EP[:SOC_interior][t]+5.4495))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_start][t]+2.7430)-5.5969*EP[:SOC_start][t]+5.4495))

    #Sim 10: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 50
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 50

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_interior][t]+3.8545)-5.8732*EP[:SOC_interior][t]+5.7950))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_start][t]+3.8545)-5.8732*EP[:SOC_start][t]+5.7950))

    #Sim 11: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 12: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 5
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 5

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_interior][t]+0.2686)-3.8333*EP[:SOC_interior][t]+3.7409))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_start][t]+0.2686)-3.8333*EP[:SOC_start][t]+3.7409))

    #Sim 13: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 10
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 10

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_interior][t]+1.7055)-4.8375*EP[:SOC_interior][t]+4.7091))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_start][t]+1.7055)-4.8375*EP[:SOC_start][t]+4.7091))

    #Sim 14: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 20
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 20

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_interior][t]+2.7430)-5.5969*EP[:SOC_interior][t]+5.4495))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_start][t]+2.7430)-5.5969*EP[:SOC_start][t]+5.4495))

    #Sim 15: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 50
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 50

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_interior][t]+3.8545)-5.8732*EP[:SOC_interior][t]+5.7950))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_start][t]+3.8545)-5.8732*EP[:SOC_start][t]+5.7950))

    #Sim 16: tau_dis = 10, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 17: tau_dis = 10, tau_ch = 5, ff_dis = 5.6, ff_ch = 5
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 5

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_interior][t]+0.2686)-3.8333*EP[:SOC_interior][t]+3.7409))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_start][t]+0.2686)-3.8333*EP[:SOC_start][t]+3.7409))

    #Sim 18: tau_dis = 10, tau_ch = 5, ff_dis = 5.6, ff_ch = 10
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 10

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_interior][t]+1.7055)-4.8375*EP[:SOC_interior][t]+4.7091))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_start][t]+1.7055)-4.8375*EP[:SOC_start][t]+4.7091))

    #Sim 19: tau_dis = 10, tau_ch = 5, ff_dis = 5.6, ff_ch = 20
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 20

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_interior][t]+2.7430)-5.5969*EP[:SOC_interior][t]+5.4495))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_start][t]+2.7430)-5.5969*EP[:SOC_start][t]+5.4495))

    #Sim 20: tau_dis = 10, tau_ch = 5, ff_dis = 5.6, ff_ch = 50
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 50

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_interior][t]+3.8545)-5.8732*EP[:SOC_interior][t]+5.7950))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_start][t]+3.8545)-5.8732*EP[:SOC_start][t]+5.7950))

    #Sim 21: tau_dis = 10, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 22: tau_dis = 10, tau_ch = 5, ff_dis = 10, ff_ch = 5
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 5

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_interior][t]+0.2686)-3.8333*EP[:SOC_interior][t]+3.7409))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-27.4627*EP[:SOC_start][t]+0.2686)-3.8333*EP[:SOC_start][t]+3.7409))

    #Sim 23: tau_dis = 10, tau_ch = 5, ff_dis = 10, ff_ch = 10
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 10

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_interior][t]+1.7055)-4.8375*EP[:SOC_interior][t]+4.7091))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-34.7843*EP[:SOC_start][t]+1.7055)-4.8375*EP[:SOC_start][t]+4.7091))

    #Sim 24: tau_dis = 10, tau_ch = 5, ff_dis = 10, ff_ch = 20
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 20

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_interior][t]+2.7430)-5.5969*EP[:SOC_interior][t]+5.4495))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-54.2938*EP[:SOC_start][t]+2.7430)-5.5969*EP[:SOC_start][t]+5.4495))

    #Sim 25: tau_dis = 10, tau_ch = 5, ff_dis = 10, ff_ch = 50
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 50

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_interior][t]+3.8545)-5.8732*EP[:SOC_interior][t]+5.7950))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-84.9298*EP[:SOC_start][t]+3.8545)-5.8732*EP[:SOC_start][t]+5.7950))

    ###########################################################################################################################

    #Code for combination analysis (TX4, NE4)

    ###########################################################################################################################

    #Sim 1: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 2: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 5
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 3: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 10
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 4: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 20
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 5: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 50
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 6: tau_dis = 100, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 7: tau_dis = 100, tau_ch = 50, ff_dis = 1.8, ff_ch = 5
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 5

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 8: tau_dis = 100, tau_ch = 50, ff_dis = 1.8, ff_ch = 10
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 10

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 9: tau_dis = 100, tau_ch = 50, ff_dis = 1.8, ff_ch = 20
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 20

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 10: tau_dis = 100, tau_ch = 50, ff_dis = 1.8, ff_ch = 50
    tau_dis = 100
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 50

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 11: tau_dis = 100, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 12: tau_dis = 100, tau_ch = 50, ff_dis = 3.2, ff_ch = 5
    tau_dis = 100
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 5

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 13: tau_dis = 100, tau_ch = 50, ff_dis = 3.2, ff_ch = 10
    tau_dis = 100
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 10

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 14: tau_dis = 100, tau_ch = 50, ff_dis = 3.2, ff_ch = 20
    tau_dis = 100
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 20

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 15: tau_dis = 100, tau_ch = 50, ff_dis = 3.2, ff_ch = 50
    tau_dis = 100
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 50

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 16: tau_dis = 100, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 17: tau_dis = 100, tau_ch = 50, ff_dis = 5.6, ff_ch = 5
    tau_dis = 100
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 5

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 18: tau_dis = 100, tau_ch = 50, ff_dis = 5.6, ff_ch = 10
    tau_dis = 100
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 10

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 19: tau_dis = 100, tau_ch = 50, ff_dis = 5.6, ff_ch = 20
    tau_dis = 100
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 20

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 20: tau_dis = 100, tau_ch = 50, ff_dis = 5.6, ff_ch = 50
    tau_dis = 100
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 50

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 21: tau_dis = 100, tau_ch = 50, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 50
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 22: tau_dis = 100, tau_ch = 50, ff_dis = 10, ff_ch = 5
    tau_dis = 100
	tau_ch = 50
    ff_dis = 10
    ff_ch = 5

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 23: tau_dis = 100, tau_ch = 50, ff_dis = 10, ff_ch = 10
    tau_dis = 100
	tau_ch = 50
    ff_dis = 10
    ff_ch = 10

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 24: tau_dis = 100, tau_ch = 50, ff_dis = 10, ff_ch = 20
    tau_dis = 100
	tau_ch = 50
    ff_dis = 10
    ff_ch = 20

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 25: tau_dis = 100, tau_ch = 50, ff_dis = 10, ff_ch = 50
    tau_dis = 100
	tau_ch = 50
    ff_dis = 10
    ff_ch = 50

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    ###########################################################################################################################

    #Code for combination analysis (TX6, NE6)

    ###########################################################################################################################

    #Sim 1: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 2: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 5
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_interior][t]+3.7528)-17.3674))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_start][t]+3.7528)-17.3674))

    #Sim 3: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 10
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_interior][t]-2.8894)-17.5915))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_start][t]-2.8894)-17.5915))

    #Sim 4: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 20
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_interior][t]+2.0954)-31.8735))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_start][t]+2.0954)-31.8735))

    #Sim 5: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 50
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_interior][t]^3+56.2328*EP[:SOC_interior][t]^2-62.0980*EP[:SOC_interior][t]+49.9892))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_start][t]^3+56.2328*EP[:SOC_start][t]^2-62.0980*EP[:SOC_start][t]+49.9892))

    #Sim 6: tau_dis = 100, tau_ch = 100, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 7: tau_dis = 100, tau_ch = 100, ff_dis = 1.8, ff_ch = 5
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 5

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_interior][t]+3.7528)-17.3674))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_start][t]+3.7528)-17.3674))

    #Sim 8: tau_dis = 100, tau_ch = 100, ff_dis = 1.8, ff_ch = 10
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 10

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_interior][t]-2.8894)-17.5915))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_start][t]-2.8894)-17.5915))

    #Sim 9: tau_dis = 100, tau_ch = 100, ff_dis = 1.8, ff_ch = 20
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 20

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_interior][t]+2.0954)-31.8735))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_start][t]+2.0954)-31.8735))

    #Sim 10: tau_dis = 100, tau_ch = 100, ff_dis = 1.8, ff_ch = 50
    tau_dis = 100
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 50

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_interior][t]^3+56.2328*EP[:SOC_interior][t]^2-62.0980*EP[:SOC_interior][t]+49.9892))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_start][t]^3+56.2328*EP[:SOC_start][t]^2-62.0980*EP[:SOC_start][t]+49.9892))

    #Sim 11: tau_dis = 100, tau_ch = 100, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 12: tau_dis = 100, tau_ch = 100, ff_dis = 3.2, ff_ch = 5
    tau_dis = 100
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 5

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_interior][t]+3.7528)-17.3674))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_start][t]+3.7528)-17.3674))

    #Sim 13: tau_dis = 100, tau_ch = 100, ff_dis = 3.2, ff_ch = 10
    tau_dis = 100
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 10

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_interior][t]-2.8894)-17.5915))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_start][t]-2.8894)-17.5915))

    #Sim 14: tau_dis = 100, tau_ch = 100, ff_dis = 3.2, ff_ch = 20
    tau_dis = 100
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 20

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_interior][t]+2.0954)-31.8735))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_start][t]+2.0954)-31.8735))

    #Sim 15: tau_dis = 100, tau_ch = 100, ff_dis = 3.2, ff_ch = 50
    tau_dis = 100
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 50

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_interior][t]^3+56.2328*EP[:SOC_interior][t]^2-62.0980*EP[:SOC_interior][t]+49.9892))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_start][t]^3+56.2328*EP[:SOC_start][t]^2-62.0980*EP[:SOC_start][t]+49.9892))

    #Sim 16: tau_dis = 100, tau_ch = 100, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 17: tau_dis = 100, tau_ch = 100, ff_dis = 5.6, ff_ch = 5
    tau_dis = 100
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 5

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_interior][t]+3.7528)-17.3674))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_start][t]+3.7528)-17.3674))

    #Sim 18: tau_dis = 100, tau_ch = 100, ff_dis = 5.6, ff_ch = 10
    tau_dis = 100
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 10

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_interior][t]-2.8894)-17.5915))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_start][t]-2.8894)-17.5915))

    #Sim 19: tau_dis = 100, tau_ch = 100, ff_dis = 5.6, ff_ch = 20
    tau_dis = 100
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 20

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_interior][t]+2.0954)-31.8735))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_start][t]+2.0954)-31.8735))

    #Sim 20: tau_dis = 100, tau_ch = 100, ff_dis = 5.6, ff_ch = 50
    tau_dis = 100
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 50

    costpermwdischarge = 0.7340 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_interior][t]^3+56.2328*EP[:SOC_interior][t]^2-62.0980*EP[:SOC_interior][t]+49.9892))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_start][t]^3+56.2328*EP[:SOC_start][t]^2-62.0980*EP[:SOC_start][t]+49.9892))

    #Sim 21: tau_dis = 100, tau_ch = 100, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 100
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 22: tau_dis = 100, tau_ch = 100, ff_dis = 10, ff_ch = 5
    tau_dis = 100
	tau_ch = 100
    ff_dis = 10
    ff_ch = 5

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_interior][t]+3.7528)-17.3674))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (22.4090*tanh(-2.8123*EP[:SOC_start][t]+3.7528)-17.3674))

    #Sim 23: tau_dis = 100, tau_ch = 100, ff_dis = 10, ff_ch = 10
    tau_dis = 100
	tau_ch = 100
    ff_dis = 10
    ff_ch = 10

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_interior][t]-2.8894)-17.5915))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-27.7870*tanh(2.2235*EP[:SOC_start][t]-2.8894)-17.5915))

    #Sim 24: tau_dis = 100, tau_ch = 100, ff_dis = 10, ff_ch = 20
    tau_dis = 100
	tau_ch = 100
    ff_dis = 10
    ff_ch = 20

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_interior][t]+2.0954)-31.8735))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (53.5148*tanh(-1.4454*EP[:SOC_start][t]+2.0954)-31.8735))

    #Sim 25: tau_dis = 100, tau_ch = 100, ff_dis = 10, ff_ch = 50
    tau_dis = 100
	tau_ch = 100
    ff_dis = 10
    ff_ch = 50

    costpermwdischarge = 0.7607 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_interior][t]^3+56.2328*EP[:SOC_interior][t]^2-62.0980*EP[:SOC_interior][t]+49.9892))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-46.0891*EP[:SOC_start][t]^3+56.2328*EP[:SOC_start][t]^2-62.0980*EP[:SOC_start][t]+49.9892))

    ###########################################################################################################################

    #Code for combination analysis (TX7, NE7)

    ###########################################################################################################################
    
    #Sim 1: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 2: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 5
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 5

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 3: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 10
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 10

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 4: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 20
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 20

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 5: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 50
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1
    ff_ch = 50

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 6: tau_dis = 10, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 7: tau_dis = 10, tau_ch = 50, ff_dis = 1.8, ff_ch = 5
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 5

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 8: tau_dis = 10, tau_ch = 50, ff_dis = 1.8, ff_ch = 10
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 10

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 9: tau_dis = 10, tau_ch = 50, ff_dis = 1.8, ff_ch = 20
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 20

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 10: tau_dis = 10, tau_ch = 50, ff_dis = 1.8, ff_ch = 50
    tau_dis = 10
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 50

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 11: tau_dis = 10, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 12: tau_dis = 10, tau_ch = 50, ff_dis = 3.2, ff_ch = 5
    tau_dis = 10
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 5

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 13: tau_dis = 10, tau_ch = 50, ff_dis = 3.2, ff_ch = 10
    tau_dis = 10
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 10

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 14: tau_dis = 10, tau_ch = 50, ff_dis = 3.2, ff_ch = 20
    tau_dis = 10
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 20

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 15: tau_dis = 10, tau_ch = 50, ff_dis = 3.2, ff_ch = 50
    tau_dis = 10
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 50

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 16: tau_dis = 10, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 17: tau_dis = 10, tau_ch = 50, ff_dis = 5.6, ff_ch = 5
    tau_dis = 10
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 5

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 18: tau_dis = 10, tau_ch = 50, ff_dis = 5.6, ff_ch = 10
    tau_dis = 10
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 10

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))

    #Sim 19: tau_dis = 10, tau_ch = 50, ff_dis = 5.6, ff_ch = 20
    tau_dis = 10
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 20

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 20: tau_dis = 10, tau_ch = 50, ff_dis = 5.6, ff_ch = 50
    tau_dis = 10
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 50

    costpermwdischarge = 0.7423 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    #Sim 21: tau_dis = 10, tau_ch = 50, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 50
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 22: tau_dis = 10, tau_ch = 50, ff_dis = 10, ff_ch = 5
    tau_dis = 10
	tau_ch = 50
    ff_dis = 10
    ff_ch = 5

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.0845 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_interior][t]+2.8402)-4.5367))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (9.6175*tanh(-2.4174*EP[:SOC_start][t]+2.8402)-4.5367))

    #Sim 23: tau_dis = 10, tau_ch = 50, ff_dis = 10, ff_ch = 10
    tau_dis = 10
	tau_ch = 50
    ff_dis = 10
    ff_ch = 10

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.1691 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_interior][t]-2.0160)-11.3886))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-22.1904*tanh(1.4980*EP[:SOC_start][t]-2.0160)-11.3886))
    
    #Sim 24: tau_dis = 10, tau_ch = 50, ff_dis = 10, ff_ch = 20
    tau_dis = 10
	tau_ch = 50
    ff_dis = 10
    ff_ch = 20

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.3381 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_interior][t]^3+5.2685*EP[:SOC_interior][t]^2-16.3416*EP[:SOC_interior][t]+20.0217))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-8.7664*EP[:SOC_start][t]^3+5.2685*EP[:SOC_start][t]^2-16.3416*EP[:SOC_start][t]+20.0217))

    #Sim 25: tau_dis = 10, tau_ch = 50, ff_dis = 10, ff_ch = 50
    tau_dis = 10
	tau_ch = 50
    ff_dis = 10
    ff_ch = 50

    costpermwdischarge = 0.7696 * 1e6
    costpermwcharge = 0.8454 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_interior][t]+2.6369)-35.9594*EP[:SOC_interior][t]+36.4992))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-24.8131*EP[:SOC_start][t]+2.6369)-35.9594*EP[:SOC_start][t]+36.4992))

    ###########################################################################################################################

    #Code for TX case study 1

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 2: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 3: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 4: tau_dis = 18, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5646 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 5: tau_dis = 18, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6339 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 6: tau_dis = 18, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6956 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 7: tau_dis = 32, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5633 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 8: tau_dis = 32, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6322 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 9: tau_dis = 32, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6935 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 10: tau_dis = 56, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5624 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 11: tau_dis = 56, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6311 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 12: tau_dis = 56, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6922 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 13: tau_dis = 100, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 14: tau_dis = 100, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 15: tau_dis = 100, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    ###########################################################################################################################

    #Code for NE case study 1

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 2: tau_dis = 10, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 3: tau_dis = 10, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 4: tau_dis = 18, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5646 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 5: tau_dis = 18, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6339 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 6: tau_dis = 18, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6956 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 7: tau_dis = 32, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5633 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 8: tau_dis = 32, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6322 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 9: tau_dis = 32, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6935 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 10: tau_dis = 56, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5624 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 11: tau_dis = 56, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6311 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 12: tau_dis = 56, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6922 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 13: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 14: tau_dis = 100, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 15: tau_dis = 100, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    ###########################################################################################################################

    #Code for TX case study 2.1

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 2: tau_dis = 18, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))/1.8)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <=(EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))/1.8)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 3: tau_dis = 32, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))/3.2)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))/3.2)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 4: tau_dis = 56, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019))/5.6)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019))/5.6)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 5: tau_dis = 100, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))/10)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))/10)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    ###########################################################################################################################

    #Code for NE case study 2.1

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 2: tau_dis = 18, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))/1.8)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))/1.8)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 3: tau_dis = 32, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))/3.2)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))/3.2)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 4: tau_dis = 56, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019))/5.6)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019))/5.6)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 5: tau_dis = 100, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))/10)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))/10)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    ###########################################################################################################################

    #Code for TX case study 2.2

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 2: tau_dis = 18, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.3670 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))/1.8)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <=(EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))/1.8)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 3: tau_dis = 32, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.2400 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))/3.2)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))/3.2)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 4: tau_dis = 56, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.1593 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019))/5.6)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019))/5.6)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 5: tau_dis = 100, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.1069 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))/10)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))/10)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    ###########################################################################################################################

    #Code for NE case study 2.2

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 2: tau_dis = 18, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.3670 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))/1.8)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))/1.8)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 3: tau_dis = 32, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.2400 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))/3.2)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))/3.2)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 4: tau_dis = 56, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.1593 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019))/5.6)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019))/5.6)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 5: tau_dis = 100, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.1069 * 1e6
    costpermwcharge = 0.0169 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))/10)
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))/10)

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    ###########################################################################################################################

    #Code for TX case study 3

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 200000
    TEGS_input[!, "Max_Cap_MWh"] .= 200000

    costpermwdischarge = 0.5667 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 2: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 184291.055
    TEGS_input[!, "Max_Cap_MWh"] .= 184291.055

    costpermwdischarge = 0.6366 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 3: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 172270.039
    TEGS_input[!, "Max_Cap_MWh"] .= 172270.039

    costpermwdischarge = 0.6987 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 4: tau_dis = 10, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 164726.165
    TEGS_input[!, "Max_Cap_MWh"] .= 164726.165

    costpermwdischarge = 0.7423 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 5: tau_dis = 10, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 160329.984
    TEGS_input[!, "Max_Cap_MWh"] .= 160329.984

    costpermwdischarge = 0.7696 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 6: tau_dis = 11, tau_ch = 5, ff_dis = 1.616, ff_ch = 1
    tau_dis = 11
	tau_ch = 5
    ff_dis = 1.616
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 200000
    TEGS_input[!, "Max_Cap_MWh"] .= 200000

    costpermwdischarge = 0.6234 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(5.3505*EP[:SOC_interior][t]-0.1047)+0.0149))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(5.3505*EP[:SOC_start][t]-0.1047)+0.0149))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 7: tau_dis = 12, tau_ch = 5, ff_dis = 2.670, ff_ch = 1
    tau_dis = 12
	tau_ch = 5
    ff_dis = 2.670
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 200000
    TEGS_input[!, "Max_Cap_MWh"] .= 200000

    costpermwdischarge = 0.6800 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.2454*EP[:SOC_interior][t]-0.1533)+0.0097))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.2454*EP[:SOC_start][t]-0.1533)+0.0097))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 8: tau_dis = 13, tau_ch = 5, ff_dis = 5.250, ff_ch = 1
    tau_dis = 13
	tau_ch = 5
    ff_dis = 5.250
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 200000
    TEGS_input[!, "Max_Cap_MWh"] .= 200000

    costpermwdischarge = 0.7367 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.3731*EP[:SOC_interior][t]-0.2211)+0.0064))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.3731*EP[:SOC_start][t]-0.2211)+0.0064))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 9: tau_dis = 14, tau_ch = 5, ff_dis = 30.600, ff_ch = 1
    tau_dis = 14
	tau_ch = 5
    ff_dis = 30.600
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 200000
    TEGS_input[!, "Max_Cap_MWh"] .= 200000

    costpermwdischarge = 0.7934 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.5482*EP[:SOC_interior][t]-0.3457)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.5482*EP[:SOC_start][t]-0.3457)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 10: tau_dis = 15, tau_ch = 5, ff_dis = 100, ff_ch = 1
    tau_dis = 15
	tau_ch = 5
    ff_dis = 100
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 208059.822
    TEGS_input[!, "Max_Cap_MWh"] .= 208059.822

    costpermwdischarge = 0.8024 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(21.9480*EP[:SOC_interior][t]-0.3568)+0.0036))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(21.9480*EP[:SOC_start][t]-0.3568)+0.0036))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 11: tau_dis = 18, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 289252.515
    TEGS_input[!, "Max_Cap_MWh"] .= 289252.515

    costpermwdischarge = 0.5646 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 12: tau_dis = 18, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 270860.904
    TEGS_input[!, "Max_Cap_MWh"] .= 270860.904

    costpermwdischarge = 0.6339 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 13: tau_dis = 18, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 256348.943
    TEGS_input[!, "Max_Cap_MWh"] .= 256348.943

    costpermwdischarge = 0.6956 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 14: tau_dis = 18, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 247080.293
    TEGS_input[!, "Max_Cap_MWh"] .= 247080.293

    costpermwdischarge = 0.7388 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_interior][t]-0.2828)+0.0047))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_start][t]-0.2828)+0.0047))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 15: tau_dis = 18, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 241620.223
    TEGS_input[!, "Max_Cap_MWh"] .= 241620.223

    costpermwdischarge = 0.7658 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_interior][t]-0.3319)+0.0039))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_start][t]-0.3319)+0.0039))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 16: tau_dis = 32, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 381972.974
    TEGS_input[!, "Max_Cap_MWh"] .= 381972.974

    costpermwdischarge = 0.5633 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 17: tau_dis = 32, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 363733.161
    TEGS_input[!, "Max_Cap_MWh"] .= 363733.161

    costpermwdischarge = 0.6322 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 18: tau_dis = 32, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 348909.949
    TEGS_input[!, "Max_Cap_MWh"] .= 348909.949

    costpermwdischarge = 0.6935 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 19: tau_dis = 32, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 339212.896
    TEGS_input[!, "Max_Cap_MWh"] .= 339212.896

    costpermwdischarge = 0.7365 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_interior][t]-0.4238)+0.0029))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_start][t]-0.4238)+0.0029))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 20: tau_dis = 32, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 333415.985
    TEGS_input[!, "Max_Cap_MWh"] .= 333415.985

    costpermwdischarge = 0.7634 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_interior][t]-0.5558)+0.0023))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_start][t]-0.5558)+0.0023))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 21: tau_dis = 56, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 463603.390
    TEGS_input[!, "Max_Cap_MWh"] .= 463603.390

    costpermwdischarge = 0.5624 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 22: tau_dis = 56, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 448065.487
    TEGS_input[!, "Max_Cap_MWh"] .= 448065.487

    costpermwdischarge = 0.6311 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 23: tau_dis = 56, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 435096.216
    TEGS_input[!, "Max_Cap_MWh"] .= 435096.216

    costpermwdischarge = 0.6922 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 24: tau_dis = 56, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 426449.636
    TEGS_input[!, "Max_Cap_MWh"] .= 426449.636

    costpermwdischarge = 0.7350 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 25: tau_dis = 56, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 421208.240
    TEGS_input[!, "Max_Cap_MWh"] .= 421208.240

    costpermwdischarge = 0.7618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_interior][t]-0.8914)+0.0013)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_start][t]-0.8914)+0.0013)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 26: tau_dis = 100, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 529879.770
    TEGS_input[!, "Max_Cap_MWh"] .= 529879.770

    costpermwdischarge = 0.5618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 27: tau_dis = 100, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 518406.844
    TEGS_input[!, "Max_Cap_MWh"] .= 518406.844

    costpermwdischarge = 0.6303 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 28: tau_dis = 100, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 508616.143
    TEGS_input[!, "Max_Cap_MWh"] .= 508616.143

    costpermwdischarge = 0.6912 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 29: tau_dis = 100, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 501953.706
    TEGS_input[!, "Max_Cap_MWh"] .= 501953.706

    costpermwdischarge = 0.7340 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 30: tau_dis = 100, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 497900.270
    TEGS_input[!, "Max_Cap_MWh"] .= 497900.270

    costpermwdischarge = 0.7607 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    ###########################################################################################################################

    #Code for NE case study 3

    ###########################################################################################################################

    #Sim 1: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 45000
    TEGS_input[!, "Max_Cap_MWh"] .= 45000

    costpermwdischarge = 0.5667 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 2: tau_dis = 10, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 41324.481
    TEGS_input[!, "Max_Cap_MWh"] .= 41324.481

    costpermwdischarge = 0.6366 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 3: tau_dis = 10, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 38528.689
    TEGS_input[!, "Max_Cap_MWh"] .= 38528.689

    costpermwdischarge = 0.6987 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 4: tau_dis = 10, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 36781.569
    TEGS_input[!, "Max_Cap_MWh"] .= 36781.569

    costpermwdischarge = 0.7423 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 5: tau_dis = 10, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 35766.056
    TEGS_input[!, "Max_Cap_MWh"] .= 35766.056

    costpermwdischarge = 0.7696 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 6: tau_dis = 11, tau_ch = 10, ff_dis = 1.616, ff_ch = 1
    tau_dis = 11
	tau_ch = 10
    ff_dis = 1.616
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 45000
    TEGS_input[!, "Max_Cap_MWh"] .= 45000

    costpermwdischarge = 0.6234 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(5.3505*EP[:SOC_interior][t]-0.1047)+0.0149))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(5.3505*EP[:SOC_start][t]-0.1047)+0.0149))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 7: tau_dis = 12, tau_ch = 10, ff_dis = 2.670, ff_ch = 1
    tau_dis = 12
	tau_ch = 10
    ff_dis = 2.670
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 45000
    TEGS_input[!, "Max_Cap_MWh"] .= 45000

    costpermwdischarge = 0.6800 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.2454*EP[:SOC_interior][t]-0.1533)+0.0097))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.2454*EP[:SOC_start][t]-0.1533)+0.0097))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 8: tau_dis = 13, tau_ch = 10, ff_dis = 5.250, ff_ch = 1
    tau_dis = 13
	tau_ch = 10
    ff_dis = 5.250
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 45000
    TEGS_input[!, "Max_Cap_MWh"] .= 45000

    costpermwdischarge = 0.7367 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.3731*EP[:SOC_interior][t]-0.2211)+0.0064))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.3731*EP[:SOC_start][t]-0.2211)+0.0064))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 9: tau_dis = 14, tau_ch = 10, ff_dis = 30.600, ff_ch = 1
    tau_dis = 14
	tau_ch = 10
    ff_dis = 30.600
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 45000
    TEGS_input[!, "Max_Cap_MWh"] .= 45000

    costpermwdischarge = 0.7934 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.5482*EP[:SOC_interior][t]-0.3457)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.5482*EP[:SOC_start][t]-0.3457)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 10: tau_dis = 15, tau_ch = 10, ff_dis = 100, ff_ch = 1
    tau_dis = 15
	tau_ch = 10
    ff_dis = 100
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 46895.560
    TEGS_input[!, "Max_Cap_MWh"] .= 46895.560

    costpermwdischarge = 0.8024 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(21.9480*EP[:SOC_interior][t]-0.3568)+0.0036))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(21.9480*EP[:SOC_start][t]-0.3568)+0.0036))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 11: tau_dis = 18, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 66368.489
    TEGS_input[!, "Max_Cap_MWh"] .= 66368.489

    costpermwdischarge = 0.5646 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 12: tau_dis = 18, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 61896.407
    TEGS_input[!, "Max_Cap_MWh"] .= 61896.407

    costpermwdischarge = 0.6339 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 13: tau_dis = 18, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 58393.229
    TEGS_input[!, "Max_Cap_MWh"] .= 58393.229

    costpermwdischarge = 0.6956 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 14: tau_dis = 18, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 56167.460
    TEGS_input[!, "Max_Cap_MWh"] .= 56167.460

    costpermwdischarge = 0.7388 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_interior][t]-0.2828)+0.0047))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_start][t]-0.2828)+0.0047))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 15: tau_dis = 18, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 54860.514
    TEGS_input[!, "Max_Cap_MWh"] .= 54860.514

    costpermwdischarge = 0.7658 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_interior][t]-0.3319)+0.0039))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_start][t]-0.3319)+0.0039))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 16: tau_dis = 32, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 89480.817
    TEGS_input[!, "Max_Cap_MWh"] .= 89480.817

    costpermwdischarge = 0.5633 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 17: tau_dis = 32, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 84857.930
    TEGS_input[!, "Max_Cap_MWh"] .= 84857.930

    costpermwdischarge = 0.6322 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 18: tau_dis = 32, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 81128.865
    TEGS_input[!, "Max_Cap_MWh"] .= 81128.865

    costpermwdischarge = 0.6935 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 19: tau_dis = 32, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 78702.782
    TEGS_input[!, "Max_Cap_MWh"] .= 78702.782

    costpermwdischarge = 0.7365 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_interior][t]-0.4238)+0.0029))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_start][t]-0.4238)+0.0029))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 20: tau_dis = 32, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 77257.494
    TEGS_input[!, "Max_Cap_MWh"] .= 77257.494

    costpermwdischarge = 0.7634 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_interior][t]-0.5558)+0.0023))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_start][t]-0.5558)+0.0023))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 21: tau_dis = 56, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 110646.147
    TEGS_input[!, "Max_Cap_MWh"] .= 110646.147

    costpermwdischarge = 0.5624 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 22: tau_dis = 56, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 106556.311
    TEGS_input[!, "Max_Cap_MWh"] .= 106556.311

    costpermwdischarge = 0.6311 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 23: tau_dis = 56, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 103164.859
    TEGS_input[!, "Max_Cap_MWh"] .= 103164.859

    costpermwdischarge = 0.6922 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 24: tau_dis = 56, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 100914.951
    TEGS_input[!, "Max_Cap_MWh"] .= 100914.951

    costpermwdischarge = 0.7350 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 25: tau_dis = 56, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 99555.421
    TEGS_input[!, "Max_Cap_MWh"] .= 99555.421

    costpermwdischarge = 0.7618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_interior][t]-0.8914)+0.0013)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_start][t]-0.8914)+0.0013)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 26: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 128425.142
    TEGS_input[!, "Max_Cap_MWh"] .= 128425.142

    costpermwdischarge = 0.5618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 27: tau_dis = 100, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 125308.109
    TEGS_input[!, "Max_Cap_MWh"] .= 125308.109

    costpermwdischarge = 0.6303 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 28: tau_dis = 100, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 122661.282
    TEGS_input[!, "Max_Cap_MWh"] .= 122661.282

    costpermwdischarge = 0.6912 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 29: tau_dis = 100, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 120867.041
    TEGS_input[!, "Max_Cap_MWh"] .= 120867.041

    costpermwdischarge = 0.7340 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 30: tau_dis = 100, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    TEGS_input[!, "Min_Cap_MWh"] .= 119778.139
    TEGS_input[!, "Max_Cap_MWh"] .= 119778.139

    costpermwdischarge = 0.7607 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))




   

    


    
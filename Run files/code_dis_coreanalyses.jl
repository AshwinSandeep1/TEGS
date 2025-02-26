    ###########################################################################################################################

    #Code for Core Analyses

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

    #Sim 6: tau_dis = 10, tau_ch = 5, ff_dis = 1, ff_ch = 1
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

    #Sim 7: tau_dis = 10, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
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

    #Sim 8: tau_dis = 10, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
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

    #Sim 9: tau_dis = 10, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
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

    #Sim 10: tau_dis = 10, tau_ch = 5, ff_dis = 10, ff_ch = 1
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

    #Sim 11: tau_dis = 10, tau_ch = 10, ff_dis = 1, ff_ch = 1
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

    #Sim 12: tau_dis = 10, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
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

    #Sim 13: tau_dis = 10, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
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

    #Sim 14: tau_dis = 10, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
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

    #Sim 15: tau_dis = 10, tau_ch = 10, ff_dis = 10, ff_ch = 1
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

    #Sim 16: tau_dis = 10, tau_ch = 50, ff_dis = 1, ff_ch = 1
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

    #Sim 17: tau_dis = 10, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
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

    #Sim 18: tau_dis = 10, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
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

    #Sim 19: tau_dis = 10, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
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

    #Sim 20: tau_dis = 10, tau_ch = 50, ff_dis = 10, ff_ch = 1
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

    #Sim 21: tau_dis = 10, tau_ch = 100, ff_dis = 1, ff_ch = 1
    tau_dis = 10
	tau_ch = 100
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5667 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_interior][t]+0.3822)-0.6622))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.6898*tanh(2.4149*EP[:SOC_start][t]+0.3822)-0.6622))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 22: tau_dis = 10, tau_ch = 100, ff_dis = 1.8, ff_ch = 1
    tau_dis = 10
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6366 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_interior][t]-0.6270)+0.3269))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (0.6802*tanh(7.3724*EP[:SOC_start][t]-0.6270)+0.3269))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 23: tau_dis = 10, tau_ch = 100, ff_dis = 3.2, ff_ch = 1
    tau_dis = 10
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6987 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_interior][t]-0.1514)+0.0105))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(8.0538*EP[:SOC_start][t]-0.1514)+0.0105))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 24: tau_dis = 10, tau_ch = 100, ff_dis = 5.6, ff_ch = 1
    tau_dis = 10
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7423 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_interior][t]-0.1879)+0.0082))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.3285*EP[:SOC_start][t]-0.1879)+0.0082))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 25: tau_dis = 10, tau_ch = 100, ff_dis = 10, ff_ch = 1
    tau_dis = 10
	tau_ch = 100
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7696 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_interior][t]-0.2238)+0.0069))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.2252*EP[:SOC_start][t]-0.2238)+0.0069))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 26: tau_dis = 18, tau_ch = 1, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 1
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5646 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 27: tau_dis = 18, tau_ch = 1, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 1
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6339 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 28: tau_dis = 18, tau_ch = 1, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 1
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6956 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 29: tau_dis = 18, tau_ch = 1, ff_dis = 5.6, ff_ch = 1
    tau_dis = 18
	tau_ch = 1
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7388 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_interior][t]-0.2828)+0.0047))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_start][t]-0.2828)+0.0047))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 30: tau_dis = 18, tau_ch = 1, ff_dis = 10, ff_ch = 1
    tau_dis = 18
	tau_ch = 1
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7658 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_interior][t]-0.3319)+0.0039))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_start][t]-0.3319)+0.0039))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 31: tau_dis = 18, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5646 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 32: tau_dis = 18, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6339 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 33: tau_dis = 18, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6956 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 34: tau_dis = 18, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7388 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_interior][t]-0.2828)+0.0047))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_start][t]-0.2828)+0.0047))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 35: tau_dis = 18, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 18
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7658 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_interior][t]-0.3319)+0.0039))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_start][t]-0.3319)+0.0039))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 36: tau_dis = 18, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5646 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 37: tau_dis = 18, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6339 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 38: tau_dis = 18, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6956 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 39: tau_dis = 18, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7388 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_interior][t]-0.2828)+0.0047))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_start][t]-0.2828)+0.0047))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 40: tau_dis = 18, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 18
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7658 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_interior][t]-0.3319)+0.0039))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_start][t]-0.3319)+0.0039))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 41: tau_dis = 18, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5646 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 42: tau_dis = 18, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6339 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 43: tau_dis = 18, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6956 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 44: tau_dis = 18, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
    tau_dis = 18
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7388 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_interior][t]-0.2828)+0.0047))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_start][t]-0.2828)+0.0047))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 45: tau_dis = 18, tau_ch = 50, ff_dis = 10, ff_ch = 1
    tau_dis = 18
	tau_ch = 50
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7658 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_interior][t]-0.3319)+0.0039))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_start][t]-0.3319)+0.0039))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 46: tau_dis = 18, tau_ch = 100, ff_dis = 1, ff_ch = 1
    tau_dis = 18
	tau_ch = 100
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5646 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_interior][t]+0)-0.0508))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0529*tanh(3.8501*EP[:SOC_start][t]+0)-0.0508))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 47: tau_dis = 18, tau_ch = 100, ff_dis = 1.8, ff_ch = 1
    tau_dis = 18
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6339 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_interior][t]-0.1384)+0.0089))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(7.7311*EP[:SOC_start][t]-0.1384)+0.0089))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 48: tau_dis = 18, tau_ch = 100, ff_dis = 3.2, ff_ch = 1
    tau_dis = 18
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6956 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_interior][t]-0.2106)+0.0062))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(11.9598*EP[:SOC_start][t]-0.2106)+0.0062))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 49: tau_dis = 18, tau_ch = 100, ff_dis = 5.6, ff_ch = 1
    tau_dis = 18
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7388 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_interior][t]-0.2828)+0.0047))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(16.1301*EP[:SOC_start][t]-0.2828)+0.0047))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 50: tau_dis = 18, tau_ch = 100, ff_dis = 10, ff_ch = 1
    tau_dis = 18
	tau_ch = 100
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7658 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_interior][t]-0.3319)+0.0039))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(19.6338*EP[:SOC_start][t]-0.3319)+0.0039))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 51: tau_dis = 32, tau_ch = 1, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 1
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5633 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 52: tau_dis = 32, tau_ch = 1, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 1
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6322 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 53: tau_dis = 32, tau_ch = 1, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 1
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6935 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 54: tau_dis = 32, tau_ch = 1, ff_dis = 5.6, ff_ch = 1
    tau_dis = 32
	tau_ch = 1
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7365 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_interior][t]-0.4238)+0.0029))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_start][t]-0.4238)+0.0029))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 55: tau_dis = 32, tau_ch = 1, ff_dis = 10, ff_ch = 1
    tau_dis = 32
	tau_ch = 1
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7634 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_interior][t]-0.5558)+0.0023))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_start][t]-0.5558)+0.0023))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 56: tau_dis = 32, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5633 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 57: tau_dis = 32, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6322 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 58: tau_dis = 32, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6935 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 59: tau_dis = 32, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7365 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_interior][t]-0.4238)+0.0029))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_start][t]-0.4238)+0.0029))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 60: tau_dis = 32, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 32
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7634 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_interior][t]-0.5558)+0.0023))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_start][t]-0.5558)+0.0023))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 61: tau_dis = 32, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5633 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 62: tau_dis = 32, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6322 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 63: tau_dis = 32, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6935 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 64: tau_dis = 32, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7365 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_interior][t]-0.4238)+0.0029))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_start][t]-0.4238)+0.0029))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 65: tau_dis = 32, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 32
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7634 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_interior][t]-0.5558)+0.0023))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_start][t]-0.5558)+0.0023))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 66: tau_dis = 32, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5633 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 67: tau_dis = 32, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6322 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 68: tau_dis = 32, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6935 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 69: tau_dis = 32, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
    tau_dis = 32
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7365 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_interior][t]-0.4238)+0.0029))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_start][t]-0.4238)+0.0029))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 70: tau_dis = 32, tau_ch = 50, ff_dis = 10, ff_ch = 1
    tau_dis = 32
	tau_ch = 50
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7634 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_interior][t]-0.5558)+0.0023))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_start][t]-0.5558)+0.0023))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 71: tau_dis = 32, tau_ch = 100, ff_dis = 1, ff_ch = 1
    tau_dis = 32
	tau_ch = 100
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5633 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_interior][t]+0)-0.0751))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0745*tanh(4.8729*EP[:SOC_start][t]+0)-0.0751))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 72: tau_dis = 32, tau_ch = 100, ff_dis = 1.8, ff_ch = 1
    tau_dis = 32
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6322 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_interior][t]-0.1836)+0.0058))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(10.4030*EP[:SOC_start][t]-0.1836)+0.0058))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 73: tau_dis = 32, tau_ch = 100, ff_dis = 3.2, ff_ch = 1
    tau_dis = 32
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6935 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_interior][t]-0.2956)+0.0040))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(17.0548*EP[:SOC_start][t]-0.2956)+0.0040))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 74: tau_dis = 32, tau_ch = 100, ff_dis = 5.6, ff_ch = 1
    tau_dis = 32
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7365 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_interior][t]-0.4238)+0.0029))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(24.3464*EP[:SOC_start][t]-0.4238)+0.0029))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 75: tau_dis = 32, tau_ch = 100, ff_dis = 10, ff_ch = 1
    tau_dis = 32
	tau_ch = 100
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7634 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_interior][t]-0.5558)+0.0023))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(31.2721*EP[:SOC_start][t]-0.5558)+0.0023))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 76: tau_dis = 56, tau_ch = 1, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 1
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5624 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 77: tau_dis = 56, tau_ch = 1, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 1
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6311 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 78: tau_dis = 56, tau_ch = 1, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 1
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6922 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 79: tau_dis = 56, tau_ch = 1, ff_dis = 5.6, ff_ch = 1
    tau_dis = 56
	tau_ch = 1
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7350 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 80: tau_dis = 56, tau_ch = 1, ff_dis = 10, ff_ch = 1
    tau_dis = 56
	tau_ch = 1
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_interior][t]-0.8914)+0.0013)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_start][t]-0.8914)+0.0013)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 81: tau_dis = 56, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5624 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 82: tau_dis = 56, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6311 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 83: tau_dis = 56, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6922 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 84: tau_dis = 56, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7350 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 85: tau_dis = 56, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 56
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_interior][t]-0.8914)+0.0013)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_start][t]-0.8914)+0.0013)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 86: tau_dis = 56, tau_ch = 10, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5624 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 87: tau_dis = 56, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6311 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 88: tau_dis = 56, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6922 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 89: tau_dis = 56, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7350 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 90: tau_dis = 56, tau_ch = 10, ff_dis = 10, ff_ch = 1
    tau_dis = 56
	tau_ch = 10
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_interior][t]-0.8914)+0.0013)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_start][t]-0.8914)+0.0013)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_interior][t]+2.8228)-0.6668))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.6877*tanh(-2.4909*EP[:SOC_start][t]+2.8228)-0.6668))

    #Sim 91: tau_dis = 56, tau_ch = 50, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 50
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5624 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 92: tau_dis = 56, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 50
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6311 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 93: tau_dis = 56, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 50
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6922 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 94: tau_dis = 56, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
    tau_dis = 56
	tau_ch = 50
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7350 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 95: tau_dis = 56, tau_ch = 50, ff_dis = 10, ff_ch = 1
    tau_dis = 56
	tau_ch = 50
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_interior][t]-0.8914)+0.0013)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_start][t]-0.8914)+0.0013)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_interior][t]-8.7310)-9897.1))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-9898.1*tanh(3.9317*EP[:SOC_start][t]-8.7310)-9897.1))

    #Sim 96: tau_dis = 56, tau_ch = 100, ff_dis = 1, ff_ch = 1
    tau_dis = 56
	tau_ch = 100
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5624 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_interior][t]+0)-0.0920))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.0914*tanh(5.6270*EP[:SOC_start][t]+0)-0.0920))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 97: tau_dis = 56, tau_ch = 100, ff_dis = 1.8, ff_ch = 1
    tau_dis = 56
	tau_ch = 100
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6311 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_interior][t]-0.2272)+0.0043))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(12.8185*EP[:SOC_start][t]-0.2272)+0.0043))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 98: tau_dis = 56, tau_ch = 100, ff_dis = 3.2, ff_ch = 1
    tau_dis = 56
	tau_ch = 100
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6922 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_interior][t]-0.3963)+0.0028))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(22.4518*EP[:SOC_start][t]-0.3963)+0.0028))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 99: tau_dis = 56, tau_ch = 100, ff_dis = 5.6, ff_ch = 1
    tau_dis = 56
	tau_ch = 100
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7350 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_interior][t]-0.6262)+0.0019)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(34.4597*EP[:SOC_start][t]-0.6262)+0.0019)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 100: tau_dis = 56, tau_ch = 100, ff_dis = 10, ff_ch = 1
    tau_dis = 56
	tau_ch = 100
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_interior][t]-0.8914)+0.0013)))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= (EP[:eTotalCap][end] *
    (1*tanh(47.5534*EP[:SOC_start][t]-0.8914)+0.0013)))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_interior][t]-5.3683)-0.8218))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (-1.8257*tanh(5.0729*EP[:SOC_start][t]-5.3683)-0.8218))

    #Sim 101: tau_dis = 100, tau_ch = 1, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 1
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 102: tau_dis = 100, tau_ch = 1, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 1
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 103: tau_dis = 100, tau_ch = 1, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 1
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 104: tau_dis = 100, tau_ch = 1, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 1
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7340 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 105: tau_dis = 100, tau_ch = 1, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 1
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7607 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_interior][t]-1.3150)-0.7653*EP[:SOC_interior][t]+0.7457))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (exp(-31.2236*EP[:SOC_start][t]-1.3150)-0.7653*EP[:SOC_start][t]+0.7457))

    #Sim 106: tau_dis = 100, tau_ch = 5, ff_dis = 1, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 1
    ff_ch = 1

    costpermwdischarge = 0.5618 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_interior][t]+0)-0.1102))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1.1103*tanh(5.8173*EP[:SOC_start][t]+0)-0.1102))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 107: tau_dis = 100, tau_ch = 5, ff_dis = 1.8, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 1.8
    ff_ch = 1

    costpermwdischarge = 0.6303 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_interior][t]-0.2656)+0.0038))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(13.9821*EP[:SOC_start][t]-0.2656)+0.0038))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 108: tau_dis = 100, tau_ch = 5, ff_dis = 3.2, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 3.2
    ff_ch = 1

    costpermwdischarge = 0.6912 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_interior][t]-0.4978)+0.0022))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(26.2860*EP[:SOC_start][t]-0.4978)+0.0022))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 109: tau_dis = 100, tau_ch = 5, ff_dis = 5.6, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 5.6
    ff_ch = 1

    costpermwdischarge = 0.7340 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_interior][t]-0.7666)+0.0015))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(41.8807*EP[:SOC_start][t]-0.7666)+0.0015))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 110: tau_dis = 100, tau_ch = 5, ff_dis = 10, ff_ch = 1
    tau_dis = 100
	tau_ch = 5
    ff_dis = 10
    ff_ch = 1

    costpermwdischarge = 0.7607 * 1e6

    @NLconstraint(EP, TEGSeffpower_interior[t in INTERIOR_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_interior][t]-1.3217)+0.0009))
    @NLconstraint(EP, TEGSeffpower_start[t in START_SUBPERIODS], EP[:vP][end,t] <= EP[:eTotalCap][end] *
    (1*tanh(66.8724*EP[:SOC_start][t]-1.3217)+0.0009))

    @NLconstraint(EP, TEGSeffcharge_interior[t in INTERIOR_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_interior][t]+1.9737)-0.7273))
    @NLconstraint(EP, TEGSeffcharge_start[t in START_SUBPERIODS], EP[:vCHARGE][end,t] <= EP[:eTotalCapCharge][end] *
    (1.8034*tanh(-1.6012*EP[:SOC_start][t]+1.9737)-0.7273))

    #Sim 111: tau_dis = 100, tau_ch = 10, ff_dis = 1, ff_ch = 1
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

    #Sim 112: tau_dis = 100, tau_ch = 10, ff_dis = 1.8, ff_ch = 1
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

    #Sim 113: tau_dis = 100, tau_ch = 10, ff_dis = 3.2, ff_ch = 1
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

    #Sim 114: tau_dis = 100, tau_ch = 10, ff_dis = 5.6, ff_ch = 1
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

    #Sim 115: tau_dis = 100, tau_ch = 10, ff_dis = 10, ff_ch = 1
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

    #Sim 116: tau_dis = 100, tau_ch = 50, ff_dis = 1, ff_ch = 1
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

    #Sim 117: tau_dis = 100, tau_ch = 50, ff_dis = 1.8, ff_ch = 1
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

    #Sim 118: tau_dis = 100, tau_ch = 50, ff_dis = 3.2, ff_ch = 1
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

    #Sim 119: tau_dis = 100, tau_ch = 50, ff_dis = 5.6, ff_ch = 1
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

    #Sim 120: tau_dis = 100, tau_ch = 50, ff_dis = 10, ff_ch = 1
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

    #Sim 121: tau_dis = 100, tau_ch = 100, ff_dis = 1, ff_ch = 1
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

    #Sim 122: tau_dis = 100, tau_ch = 100, ff_dis = 1.8, ff_ch = 1
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

    #Sim 123: tau_dis = 100, tau_ch = 100, ff_dis = 3.2, ff_ch = 1
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

    #Sim 124: tau_dis = 100, tau_ch = 100, ff_dis = 5.6, ff_ch = 1
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

    #Sim 125: tau_dis = 100, tau_ch = 100, ff_dis = 10, ff_ch = 1
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
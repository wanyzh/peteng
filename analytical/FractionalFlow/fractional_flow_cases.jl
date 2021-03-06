function test_water_flood()
    fluids = oil_water_fluids()
    rel_perms = oil_water_rel_perms()
    core_flood = core_flooding()
    core_props = core_properties()
    pv, R, xt, sw = water_flood(core_props, fluids, rel_perms, core_flood)
    fw, dfw = fractional_flow_function(rel_perms, fluids)
    sw_tmp = linspace(0,1,100)
    # plot(sw_tmp, fw.(sw_tmp), xlabel = "Sw", ylabel="fw", label="")
    # plot!(sw_tmp, dfw.(sw_tmp))
    figure(1)
    plot(pv, R) 
    xlabel("PV injected")
    ylabel("Recovery factor") 
    title("Water flooding")
    figure(2)
    plot(xt, sw)
    xlabel("x/t [-]")
    ylabel("Water saturation [-]")
end

function test_lowsal_water_flood()
    fluids_hs = oil_water_fluids(mu_water=1e-3, mu_oil=2e-3)
    fluids_ls = oil_water_fluids(mu_water=1e-3, mu_oil=2e-3)
    rel_perms_hs = oil_water_rel_perms(krw0=0.4, kro0=0.9, 
        swc=0.15, sor=0.2, nw=2.0, no = 2.0)
    rel_perms_ls = oil_water_rel_perms(krw0=0.3, kro0=0.95, 
        swc=0.15, sor=0.15, nw=2.0, no = 2.0)
    core_flood = core_flooding(u_inj=1.15e-5, pv_inject=5.0, p_back=1e5, sw_init=0.2, sw_inj=1.0, rel_perms=rel_perms_hs)
    core_props = core_properties()
    pv, R, xt, sw = low_sal_water_flood(core_props, fluids_ls, fluids_hs, rel_perms_hs, 
        rel_perms_ls, core_flood)
    # fw, dfw = fractional_flow_function(rel_perms, fluids)
    # sw_tmp = linspace(0,1,100)
    # plot(sw_tmp, fw.(sw_tmp), xlabel = "Sw", ylabel="fw", label="")
    # plot!(sw_tmp, dfw.(sw_tmp))
    figure(1)
    plot(pv, R) 
    xlabel("PV injected")
    ylabel("Recovery factor") 
    title("Water flooding")
    figure(2)
    plot(xt, sw)
    xlabel("x/t [-]")
    ylabel("Water saturation [-]")
end

function test_lowsal_numeric()
    fluids_hs = oil_water_fluids(mu_water=1e-3, mu_oil=2e-3)
    fluids_ls = oil_water_fluids(mu_water=1e-3, mu_oil=2e-3)
    rel_perms_hs = oil_water_rel_perms(krw0=0.4, kro0=0.9, 
        swc=0.15, sor=0.2, nw=2.0, no = 2.0)
    rel_perms_ls = oil_water_rel_perms(krw0=0.3, kro0=0.95, 
        swc=0.15, sor=0.15, nw=2.0, no = 2.0)
    core_flood = core_flooding(u_inj=1.15e-5, pv_inject=5.0, p_back=1e5, sw_init=0.8, sw_inj=1.0, rel_perms=rel_perms_hs)
    core_props = core_properties()
    pv, R, xt, sw = low_sal_water_flood(core_props, fluids_ls, fluids_hs, rel_perms_hs, 
        rel_perms_ls, core_flood)
    t_sec, pv_num, rec_fact, xt_num, sw_num, c_old, c_out_sal = forced_imb_implicit(core_props, fluids_ls, fluids_hs, rel_perms_hs, 
        rel_perms_ls, core_flood)
    # fw, dfw = fractional_flow_function(rel_perms, fluids)
    # sw_tmp = linspace(0,1,100)
    # plot(sw_tmp, fw.(sw_tmp), xlabel = "Sw", ylabel="fw", label="")
    # plot!(sw_tmp, dfw.(sw_tmp))
    figure(1)
    plot(pv_num, rec_fact, "--") 
    xlabel("PV injected")
    ylabel("Recovery factor") 
    title("Water flooding")
    figure(2)
    plot(xt_num, sw_num)
    JFVM.visualizeCells(c_old)
    xlabel("x/t [-]")
    ylabel("Water saturation [-]")
end

function test_adsorption_lowsal_water_flood()
    fluids_hs = oil_water_fluids(mu_water=1e-3, mu_oil=2e-3)
    fluids_ls = oil_water_fluids(mu_water=0.8e-3, mu_oil=2e-3)
    rel_perms_hs = oil_water_rel_perms(krw0=0.4, kro0=0.9, 
        swc=0.15, sor=0.2, nw=2.0, no = 2.0)
    rel_perms_ls = oil_water_rel_perms(krw0=0.3, kro0=0.95, 
        swc=0.15, sor=0.15, nw=2.0, no = 2.0)
    core_flood = core_flooding()
    core_props = core_properties()
    pv, R, xt, sw = single_ion_adsorption_water_flood(core_props, fluids_ls, fluids_hs, rel_perms_hs, 
        rel_perms_ls, core_flood, 0.2)
    # fw, dfw = fractional_flow_function(rel_perms, fluids)
    # sw_tmp = linspace(0,1,100)
    # plot(sw_tmp, fw.(sw_tmp), xlabel = "Sw", ylabel="fw", label="")
    # plot!(sw_tmp, dfw.(sw_tmp))
    figure(1)
    plot(pv, R) 
    xlabel("PV injected")
    ylabel("Recovery factor") 
    title("Water flooding")
    figure(2)
    plot(xt, sw)
    xlabel("x/t [m/s]")
    ylabel("Water saturation [-]")
end

function test_adsorption_lowsal_tertiary_water_flood()
    fluids_hs = oil_water_fluids(mu_water=1e-3, mu_oil=2e-3)
    fluids_ls = oil_water_fluids(mu_water=0.8e-3, mu_oil=2e-3)
    rel_perms_hs = oil_water_rel_perms(krw0=0.4, kro0=0.9, 
        swc=0.15, sor=0.2, nw=2.0, no = 2.0)
    rel_perms_ls = oil_water_rel_perms(krw0=0.3, kro0=0.95, 
        swc=0.15, sor=0.15, nw=2.0, no = 2.0)
    core_flood = core_flooding()
    core_props = core_properties()
    pv, R, xt, sw = single_ion_adsorption_tertiary_water_flood(core_props, fluids_ls, fluids_hs, rel_perms_hs, 
        rel_perms_ls, core_flood, 0.2)
    # fw, dfw = fractional_flow_function(rel_perms, fluids)
    # sw_tmp = linspace(0,1,100)
    # plot(sw_tmp, fw.(sw_tmp), xlabel = "Sw", ylabel="fw", label="")
    # plot!(sw_tmp, dfw.(sw_tmp))
    figure(1)
    plot(pv, R) 
    xlabel("PV injected")
    ylabel("Recovery factor") 
    title("Water flooding")
    figure(2)
    plot(xt, sw)
    xlabel("x/t [m/s]")
    ylabel("Water saturation [-]")
end

function test_solvent_water_flood()
    fluids_oil_water = oil_water_fluids(mu_water=1e-3, mu_oil=1e-3)
    fluids_solvent = oil_water_fluids(mu_water=1.1e-3, mu_oil=2e-3)
    rel_perms_oil_water = oil_water_rel_perms(krw0=0.4, kro0=0.9, 
        swc=0.15, sor=0.2, nw=2.0, no = 2.0)
    rel_perms_solvent = oil_water_rel_perms(krw0=0.4, kro0=0.9, 
    swc=0.15, sor=0.15, nw=2.0, no = 2.0)
    core_flood = core_flooding()
    core_props = core_properties()
    K_eq = 2.0
    pv, R, xt, sw = water_soluble_solvent_flood(core_props, fluids_solvent, fluids_oil_water, 
        rel_perms_oil_water, rel_perms_solvent, core_flood, K_eq)
    # fw, dfw = fractional_flow_function(rel_perms, fluids)
    # sw_tmp = linspace(0,1,100)
    # plot(sw_tmp, fw.(sw_tmp), xlabel = "Sw", ylabel="fw", label="")
    # plot!(sw_tmp, dfw.(sw_tmp))
    figure(1)
    plot(pv, R) 
    xlabel("PV injected")
    ylabel("Recovery factor") 
    title("Water flooding")
    figure(2)
    plot(xt, sw)
    xlabel("x/t [m/s]")
    ylabel("Water saturation [-]")
end
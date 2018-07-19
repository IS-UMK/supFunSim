function chkSim___tg_s02_Geometry___02_Indices___Plot_003(sim_geo_deep)
    hold on
    trisurf(                   ...
        sim_geo_deep.tri,      ...
        sim_geo_deep.pnt(:,1), ...
        sim_geo_deep.pnt(:,2), ...
        sim_geo_deep.pnt(:,3), ...
        'facealpha',0.1,       ...
        'facecolor','m',       ...
        'edgecolor','m',       ...
        'edgealpha',0.2);
    ccrender([-150,150],'finish','matte')
end

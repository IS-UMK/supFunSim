function chkSim___tg_s02_Geometry___01_RandSamp(sim_geo_cort,sel_atl)
    fprintf('\n');
    disp(cell2table([num2cell(sim_geo_cort.lstROIs)',{sel_atl.Atlas(sel_atl.atl).Scouts(sim_geo_cort.lstROIs).Label}'],'VariableNames',{'ROI_number','ROI_name'}));
    fprintf('\n');
end

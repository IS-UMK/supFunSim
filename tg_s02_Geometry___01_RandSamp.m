clearvars sim_geo_cort ii jj kk nn tmp*
sim_geo_cort.numROIs = size(sel_atl.Atlas(sel_atl.atl).Scouts,2);

if SETUP.rROI
    disp('CC: using random ROI locations')
    sim_geo_cort.lstROIs = randsample([1:sim_geo_cort.numROIs],size(SETUP.SRCS,1));
else
    disp('CC: using predefined ROI locations')
    sim_geo_cort.lstROIs = [31 30 34 29 56 51 84 53 83 58 57];
    sim_geo_cort.lstROIs = sim_geo_cort.lstROIs(1:size(SETUP.SRCS,1));
end


if SETUP.rPNT
    disp('CC: using random source locations')
else
    disp('CC: using predefined source locations')
    sim_geo_cort.lstROIs(1) = 31;
end

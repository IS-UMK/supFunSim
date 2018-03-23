
clearvars sim_geo_cort ii jj kk nn tmp*
sim_geo_cort.numROIs = size(sel_atl.Atlas(sel_atl.atl).Scouts,2);

if 0, SETUP.rROI = 0; end;

if SETUP.rROI
    sim_geo_cort.lstROIs = randsample([1:sim_geo_cort.numROIs],size(SETUP.SRCS,1));
else
    sim_geo_cort.lstROIs = [30 29 56 34 31 51 84 53 83 58 57];
    sim_geo_cort.lstROIs = sim_geo_cort.lstROIs(1:size(SETUP.SRCS,1));
end

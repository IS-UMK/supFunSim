sim_geo_cort.indROIs = [];
for ii = 1:length(sim_geo_cort.lstROIs)
    tmp_roi = sim_geo_cort.lstROIs(ii);
    sim_geo_cort.indROIs(ii).pntNum00 = sel_atl.Atlas(sel_atl.atl).Scouts(tmp_roi).Vertices';
    sim_geo_cort.indROIs(ii).triNum00 = find(all(ismember(sel_atl.tri,sim_geo_cort.indROIs(ii).pntNum00),2));
end
clearvars ii jj kk nn tmp*

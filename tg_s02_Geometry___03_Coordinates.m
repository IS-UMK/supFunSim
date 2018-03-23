
sim_geo_cort.distrROIs    = SETUP.SRCS;
sim_geo_cort.distrROIsSum = sum(SETUP.SRCS,2);
sim_geo_cort.bulkSRC = {};
for ii = 1:length(sim_geo_cort.distrROIsSum)
    sim_geo_cort.bulkSRC{ii,1} = randsample(sim_geo_cort.indROIs(ii).pntNum00,sim_geo_cort.distrROIsSum(ii));
end
sim_geo_cort.splitSRC = {};
for ii = 1:length(sim_geo_cort.distrROIsSum)
    sim_geo_cort.splitSRC(ii,:) = mat2cell(sim_geo_cort.bulkSRC{ii},sim_geo_cort.distrROIs(ii,:),1)';
end
sim_geo_cort.mergeSRC = {};
for ii = 1:3
    sim_geo_cort.mergeSRC{ii} = cat(1,sim_geo_cort.splitSRC{:,ii});
end
sim_geo_cort.pos_orig = {};
sim_geo_cort.ori_orig = {};
sim_geo_cort.pos_pert = {};
sim_geo_cort.ori_pert = {};
for ii = 1:3
    sim_geo_cort.pos_orig{ii} = sel_atl.pnt(sim_geo_cort.mergeSRC{ii},:);
    sim_geo_cort.ori_orig{ii} = sel_atl.vn1(sim_geo_cort.mergeSRC{ii},:);
    sim_geo_cort.pos_pert{ii} = sim_geo_cort.pos_orig{ii};
    sim_geo_cort.ori_pert{ii} = sim_geo_cort.ori_orig{ii};
end
clearvars ii jj kk nn tmp*

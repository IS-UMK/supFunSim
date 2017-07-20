clearvars sel_geo_deep ii jj kk ll nn tmp*

sim_geo_deep = sel_geo_deep_icosahedron642;
sim_geo_deep = sel_geo_deep_thalami;

sim_geo_deep.bulkSRC =  randsample(1:size(sim_geo_deep.pnt,1),sum(SETUP.DEEP))';


[sim_geo_deep.mergeSRC{1},sim_geo_deep.mergeSRC{2},sim_geo_deep.mergeSRC{3}] = deal([]);


sim_geo_deep.mergeSRC{1,1} = sim_geo_deep.bulkSRC(1:SETUP.DEEP(1));
sim_geo_deep.mergeSRC{1,2} = sim_geo_deep.bulkSRC(1+SETUP.DEEP(1):SETUP.DEEP(1)+SETUP.DEEP(2));
sim_geo_deep.mergeSRC{1,3} = sim_geo_deep.bulkSRC(1+SETUP.DEEP(1)+SETUP.DEEP(2):SETUP.DEEP(1)+SETUP.DEEP(2)+SETUP.DEEP(3));



sim_geo_deep.pos_orig = {};
sim_geo_deep.ori_orig = {};
sim_geo_deep.pos_pert = {};
sim_geo_deep.ori_pert = {};

for ii = 1:3
    sim_geo_deep.pos_orig{ii} = sim_geo_deep.pnt(sim_geo_deep.mergeSRC{ii},:);
    sim_geo_deep.ori_orig{ii} = sim_geo_deep.vn1(sim_geo_deep.mergeSRC{ii},:);
    sim_geo_deep.pos_pert{ii} = sim_geo_deep.pos_orig{ii};
    sim_geo_deep.ori_pert{ii} = sim_geo_deep.ori_orig{ii};
end

clearvars ii jj kk nn tmp*

sim_geo = sim_geo_cort;
for ii = 1:3,
    sim_geo.pos_orig{ii} = [sim_geo.pos_orig{ii};sim_geo_deep.pos_orig{ii}];
    sim_geo.ori_orig{ii} = [sim_geo.ori_orig{ii};sim_geo_deep.ori_orig{ii}];
    sim_geo.pos_pert{ii} = [sim_geo.pos_pert{ii};sim_geo_deep.pos_pert{ii}];
    sim_geo.ori_pert{ii} = [sim_geo.ori_pert{ii};sim_geo_deep.ori_pert{ii}];
end;

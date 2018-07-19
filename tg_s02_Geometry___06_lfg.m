% WARNING:: suppress warning about MATLAB version and CFG tracking
if 0
    TMP_S = warning('off','all');
end

tmp_cfg            = [];
tmp_cfg.grid.unit  = 'mm';
tmp_cfg.reducerank = 'no';
tmp_cfg.normalize  = 'no';
tmp_cfg.elec       = sel_ele;
tmp_cfg.vol        = sel_vol;

ii = 1;
tmp_cfg.grid.pos          = sim_geo.pos_orig{ii};
tmp_cfg.grid.mom          = transpose(sim_geo.ori_orig{ii});
sim_lfg_SrcActiv_orig.lfg = ft_prepare_leadfield(tmp_cfg);
sim_lfg_SrcActiv_orig.LFG = cat(2,sim_lfg_SrcActiv_orig.lfg.leadfield{:});

tmp_cfg.grid.pos          = sim_geo.pos_pert{ii};
tmp_cfg.grid.mom          = transpose(sim_geo.ori_pert{ii});
sim_lfg_SrcActiv_pert.lfg = ft_prepare_leadfield(tmp_cfg);
sim_lfg_SrcActiv_pert.LFG = cat(2,sim_lfg_SrcActiv_pert.lfg.leadfield{:});

ii = 2;
tmp_cfg.grid.pos          = sim_geo.pos_orig{ii};
tmp_cfg.grid.mom          = transpose(sim_geo.pos_orig{ii});
sim_lfg_IntNoise_orig.lfg = ft_prepare_leadfield(tmp_cfg);
sim_lfg_IntNoise_orig.LFG = cat(2,sim_lfg_IntNoise_orig.lfg.leadfield{:});

tmp_cfg.grid.pos          = sim_geo.pos_pert{ii};
tmp_cfg.grid.mom          = transpose(sim_geo.pos_pert{ii});
sim_lfg_IntNoise_pert.lfg = ft_prepare_leadfield(tmp_cfg);
sim_lfg_IntNoise_pert.LFG = cat(2,sim_lfg_IntNoise_pert.lfg.leadfield{:});

ii = 3;
tmp_cfg.grid.pos          = sim_geo.pos_orig{ii};
tmp_cfg.grid.mom          = transpose(sim_geo.pos_orig{ii});
sim_lfg_BcgNoise_orig.lfg = ft_prepare_leadfield(tmp_cfg);
sim_lfg_BcgNoise_orig.LFG = cat(2,sim_lfg_BcgNoise_orig.lfg.leadfield{:});

tmp_cfg.grid.pos          = sim_geo.pos_pert{ii};
tmp_cfg.grid.mom          = transpose(sim_geo.pos_pert{ii});
sim_lfg_BcgNoise_pert.lfg = ft_prepare_leadfield(tmp_cfg);
sim_lfg_BcgNoise_pert.LFG = cat(2,sim_lfg_BcgNoise_pert.lfg.leadfield{:});

clearvars ii jj kk nn tmp*

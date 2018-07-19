clearvars sim_sig_MesNoise tmp*
sim_sig_MesNoise.inf = 'RANDN based signal for measurment noise';
sim_sig_MesNoise.sigSNS_pre = randn([SETUP.n00,size(sel_ele.chanpos,1),SETUP.K00]);
sim_sig_MesNoise.sigSNS_pst = randn([SETUP.n00,size(sel_ele.chanpos,1),SETUP.K00]);


clearvars ii jj kk nn tmp*
for kk = 1:SETUP.K00
    sim_sig_SrcActiv.sigSNS_pre(:,:,kk) = (sim_lfg_SrcActiv_orig.LFG*sim_sig_SrcActiv.sigSRC_pre(:,:,kk)')';
    sim_sig_SrcActiv.sigSNS_pst(:,:,kk) = (sim_lfg_SrcActiv_orig.LFG*sim_sig_SrcActiv.sigSRC_pst(:,:,kk)')';
    sim_sig_IntNoise.sigSNS_pre(:,:,kk) = (sim_lfg_IntNoise_orig.LFG*sim_sig_IntNoise.sigSRC_pre(:,:,kk)')';
    sim_sig_IntNoise.sigSNS_pst(:,:,kk) = (sim_lfg_IntNoise_orig.LFG*sim_sig_IntNoise.sigSRC_pst(:,:,kk)')';
    sim_sig_BcgNoise.sigSNS_pre(:,:,kk) = (sim_lfg_BcgNoise_orig.LFG*sim_sig_BcgNoise.sigSRC_pre(:,:,kk)')';
    sim_sig_BcgNoise.sigSNS_pst(:,:,kk) = (sim_lfg_BcgNoise_orig.LFG*sim_sig_BcgNoise.sigSRC_pst(:,:,kk)')';
end
clearvars ii jj kk nn tmp*

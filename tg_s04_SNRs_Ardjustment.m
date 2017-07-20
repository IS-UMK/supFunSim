clearvars ii jj kk nn tmp*

sim_sig_AdjSNRs.SrcActivPre = sim_sig_SrcActiv.sigSNS_pre;
sim_sig_AdjSNRs.SrcActivPst = sim_sig_SrcActiv.sigSNS_pst;
sim_sig_AdjSNRs.IntNoisePre = sim_sig_IntNoise.sigSNS_pre;
sim_sig_AdjSNRs.IntNoisePst = sim_sig_IntNoise.sigSNS_pst;
sim_sig_AdjSNRs.BcgNoisePre = sim_sig_BcgNoise.sigSNS_pre;
sim_sig_AdjSNRs.BcgNoisePst = sim_sig_BcgNoise.sigSNS_pst;
sim_sig_AdjSNRs.MesNoisePre = sim_sig_MesNoise.sigSNS_pre;
sim_sig_AdjSNRs.MesNoisePst = sim_sig_MesNoise.sigSNS_pst;
for kk = 1:SETUP.K00
    sim_sig_AdjSNRs.IntNoisePre(:,:,kk) = rawAdjTotSNRdB(sim_sig_AdjSNRs.SrcActivPre(:,:,kk),sim_sig_AdjSNRs.IntNoisePre(:,:,kk),SETUP.SINR);
    sim_sig_AdjSNRs.IntNoisePst(:,:,kk) = rawAdjTotSNRdB(sim_sig_AdjSNRs.SrcActivPst(:,:,kk),sim_sig_AdjSNRs.IntNoisePst(:,:,kk),SETUP.SINR);
    sim_sig_AdjSNRs.BcgNoisePre(:,:,kk) = rawAdjTotSNRdB(sim_sig_AdjSNRs.SrcActivPre(:,:,kk),sim_sig_AdjSNRs.BcgNoisePre(:,:,kk),SETUP.SBNR);
    sim_sig_AdjSNRs.BcgNoisePst(:,:,kk) = rawAdjTotSNRdB(sim_sig_AdjSNRs.SrcActivPst(:,:,kk),sim_sig_AdjSNRs.BcgNoisePst(:,:,kk),SETUP.SBNR);
    sim_sig_AdjSNRs.MesNoisePre(:,:,kk) = rawAdjTotSNRdB(sim_sig_AdjSNRs.SrcActivPre(:,:,kk),sim_sig_AdjSNRs.MesNoisePre(:,:,kk),SETUP.SMNR);
    sim_sig_AdjSNRs.MesNoisePst(:,:,kk) = rawAdjTotSNRdB(sim_sig_AdjSNRs.SrcActivPst(:,:,kk),sim_sig_AdjSNRs.MesNoisePst(:,:,kk),SETUP.SMNR);
end

clearvars ii jj kk nn tmp*

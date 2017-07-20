clearvars sim_sig_SrcActiv tmp*
sim_sig_SrcActiv = cccSim___makeSimSig(SETUP,1,'MVAR based signal for sources activity');
clearvars ii jj kk nn tmp*

if SETUP.ERPs > 0

    sim_sig_SrcActiv.sigSRC_pst_orig = sim_sig_SrcActiv.sigSRC_pst;
    sim_sig_SrcActiv.sigSRC_pre_orig = sim_sig_SrcActiv.sigSRC_pre;

    tmp_LB = -5;
    tmp_UB = 7;
    tmp_NN = SETUP.n00;
    tmp_PP = 1;
    for ee = 1:1:SETUP.ERPs
        tmp_PP = mod(ee,3)+1;
        sim_sig_SrcActiv.ERPs(ee,:) = gauswavf(tmp_LB,tmp_UB,tmp_NN,tmp_PP);
    end
    sim_sig_SrcActiv.ERPs_pst = transpose(sim_sig_SrcActiv.ERPs);
    sim_sig_SrcActiv.ERPs_pst(size(sim_sig_SrcActiv.sigSRC_pst,1),size(sim_sig_SrcActiv.sigSRC_pst,2)) = 0;
    sim_sig_SrcActiv.ERPs_pst = cat(3,repmat(sim_sig_SrcActiv.ERPs_pst,[1,1,SETUP.K00]));

    sim_sig_SrcActiv.sigSRC_pst = sim_sig_SrcActiv.sigSRC_pst + 20*sim_sig_SrcActiv.ERPs_pst;

end

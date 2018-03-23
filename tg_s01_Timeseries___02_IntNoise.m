
clearvars sim_sig_IntNoise tmp*
sim_sig_IntNoise = sim_sig_SrcActiv;

sim_sig_IntNoise.inf        = 'MVAR based signal for interference (biological) noise activity sources';
tmp_IntNoiseCol = 2;

if SETUP.TELL,disp('Getting base for IntNoise...');end;
sim_sig_IntNoise.sigSRC_pre = -sim_sig_IntNoise.sigSRC_pre;
sim_sig_IntNoise.sigSRC_pst = -sim_sig_IntNoise.sigSRC_pst;
[sim_sig_IntNoise.w01,sim_sig_IntNoise.A01,sim_sig_IntNoise.C01,sim_sig_IntNoise.SBC01,sim_sig_IntNoise.FPE01,sim_sig_IntNoise.th01] = deal([]);

if SETUP.TELL,disp('Populating signals for IntNoise...');end;
sim_sig_IntNoise.sigSRC_pre = repmat(sim_sig_IntNoise.sigSRC_pre,1,ceil( (sum(SETUP.SRCS(:,tmp_IntNoiseCol))+SETUP.DEEP(1,tmp_IntNoiseCol))/size(sim_sig_IntNoise.sigSRC_pre,2)),1);
sim_sig_IntNoise.sigSRC_pst = repmat(sim_sig_IntNoise.sigSRC_pst,1,ceil( (sum(SETUP.SRCS(:,tmp_IntNoiseCol))+SETUP.DEEP(1,tmp_IntNoiseCol))/size(sim_sig_IntNoise.sigSRC_pst,2)),1);

if SETUP.TELL,disp('Reducing dimensionality of IntNoise...');end;
sim_sig_IntNoise.sigSRC_pre = sim_sig_IntNoise.sigSRC_pre(:,1:(sum(SETUP.SRCS(:,tmp_IntNoiseCol))+SETUP.DEEP(1,tmp_IntNoiseCol)),:);
sim_sig_IntNoise.sigSRC_pst = sim_sig_IntNoise.sigSRC_pst(:,1:(sum(SETUP.SRCS(:,tmp_IntNoiseCol))+SETUP.DEEP(1,tmp_IntNoiseCol)),:);

if SETUP.TELL,disp('Backing-up IntNoise before white noise admixture...');end;
sim_sig_IntNoise.sigSRC_pre_b4admix = sim_sig_IntNoise.sigSRC_pre;
sim_sig_IntNoise.sigSRC_pst_b4admix = sim_sig_IntNoise.sigSRC_pst;

if SETUP.WhtNoiseAddFlg
    if SETUP.TELL,disp('Adding some white noise to the biological noise activity...');end;
    sim_sig_IntNoise.noiseAdmix_pre = randn(size(sim_sig_IntNoise.sigSRC_pre));
    sim_sig_IntNoise.noiseAdmix_pst = randn(size(sim_sig_IntNoise.sigSRC_pst));
    for kk = 1:SETUP.K00
        sim_sig_IntNoise.noiseAdmix_pre(:,:,kk) = rawAdjTotSNRdB(sim_sig_IntNoise.sigSRC_pre(:,:,kk),sim_sig_IntNoise.noiseAdmix_pre(:,:,kk),SETUP.WhtNoiseAddSNR);
        sim_sig_IntNoise.noiseAdmix_pst(:,:,kk) = rawAdjTotSNRdB(sim_sig_IntNoise.sigSRC_pst(:,:,kk),sim_sig_IntNoise.noiseAdmix_pst(:,:,kk),SETUP.WhtNoiseAddSNR);
    end
    sim_sig_IntNoise.sigSRC_pre = sim_sig_IntNoise.sigSRC_pre+sim_sig_IntNoise.noiseAdmix_pre;
    sim_sig_IntNoise.sigSRC_pst = sim_sig_IntNoise.sigSRC_pst+sim_sig_IntNoise.noiseAdmix_pst;
end

if SETUP.TELL,disp('Fitting MVAR model to generated signal...');end;
[sim_sig_IntNoise.w01,sim_sig_IntNoise.A01,sim_sig_IntNoise.C01,sim_sig_IntNoise.SBC01,sim_sig_IntNoise.FPE01,sim_sig_IntNoise.th01] = arfit(sim_sig_IntNoise.sigSRC_pst,sim_sig_IntNoise.P00-round(sim_sig_IntNoise.P00/2),sim_sig_IntNoise.P00+round(sim_sig_IntNoise.P00/2));

if 0
    sim_sig_IntNoise = rmfield(sim_sig_IntNoise,{'sigSRC_pre_b4admix','sigSRC_pst_b4admix','noiseAdmix_pre','noiseAdmix_pst'})
end

clearvars ii jj kk nn tmp*

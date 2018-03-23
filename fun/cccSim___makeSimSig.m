
function sim_sig_SrcActiv = cccSim___makeSimSig(SETUP,set_COL,varargin)
    sim_sig_SrcActiv.inf        = '';
    sim_sig_SrcActiv.S00        = [];
    sim_sig_SrcActiv.P00        = [];
    sim_sig_SrcActiv.M00        = [];
    sim_sig_SrcActiv.A00        = zeros([0,1]);
    sim_sig_SrcActiv.mdlStabH   = [];
    sim_sig_SrcActiv.mdlStabM   = [];
    sim_sig_SrcActiv.w00        = [];
    sim_sig_SrcActiv.C00        = [];
    sim_sig_SrcActiv.n00        = [];
    sim_sig_SrcActiv.K00        = [];
    sim_sig_SrcActiv.sigSRC_pre = permute([],[3,2,1]);
    sim_sig_SrcActiv.sigSRC_pst = permute([],[3,2,1]);
    sim_sig_SrcActiv.w01        = [];
    sim_sig_SrcActiv.A01        = zeros([0,1]);
    sim_sig_SrcActiv.C01        = [];
    sim_sig_SrcActiv.SBC01      = [];
    sim_sig_SrcActiv.FPE01      = [];
    sim_sig_SrcActiv.th01       = [];
    if ~isempty(varargin)
        sim_sig_SrcActiv.inf = varargin{end};
    end
    sim_sig_SrcActiv.S00 = sum(SETUP.SRCS(:,set_COL))+SETUP.DEEP(1,set_COL); % number of signals
    if sim_sig_SrcActiv.S00 > 0
        sim_sig_SrcActiv.P00 = SETUP.P00;                     % order of the MVAR model used to generate time-courses
        sim_sig_SrcActiv.M00 = cccSim___diagonMask(sim_sig_SrcActiv.S00,SETUP.FRAC); % MVAR coefficients mask
        sim_sig_SrcActiv.A00 = cccSim___stableMVAR(sim_sig_SrcActiv.S00,sim_sig_SrcActiv.P00,sim_sig_SrcActiv.M00,SETUP.RNG,SETUP.STAB,SETUP.ITER);
        [sim_sig_SrcActiv.mdlStabH,sim_sig_SrcActiv.mdlStabM] = rawIsStableMVAR(sim_sig_SrcActiv.A00,1);
        sim_sig_SrcActiv.w00 = zeros(sim_sig_SrcActiv.S00,1); % expected value for time-courses
        sim_sig_SrcActiv.C00 = eye(sim_sig_SrcActiv.S00);     % covariance of MVAR model's "driving noise"
        sim_sig_SrcActiv.n00 = SETUP.n00;                     % number of time samples
        sim_sig_SrcActiv.K00 = SETUP.K00;                     % number of independent realizations of the driving AR models
        sim_sig_SrcActiv.sigSRC_pre = 10*arsim(sim_sig_SrcActiv.w00,sim_sig_SrcActiv.A00,sim_sig_SrcActiv.C00,[sim_sig_SrcActiv.n00,2*sim_sig_SrcActiv.K00],1e3); % 10e-6; % Current density (10nA*mm)
        sim_sig_SrcActiv.sigSRC_pst = sim_sig_SrcActiv.sigSRC_pre(:,:,[end/2+1:end]);
        sim_sig_SrcActiv.sigSRC_pre = sim_sig_SrcActiv.sigSRC_pre(:,:,[1:end/2]);
        if SETUP.TELL,disp('Fitting MVAR model to generated signal...');end;
        [sim_sig_SrcActiv.w01,sim_sig_SrcActiv.A01,sim_sig_SrcActiv.C01,sim_sig_SrcActiv.SBC01,sim_sig_SrcActiv.FPE01,sim_sig_SrcActiv.th01] = arfit(sim_sig_SrcActiv.sigSRC_pst,sim_sig_SrcActiv.P00-round(sim_sig_SrcActiv.P00/2),sim_sig_SrcActiv.P00+round(sim_sig_SrcActiv.P00/2));
    end
end

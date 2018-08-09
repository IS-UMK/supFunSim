% if exist('fPath'), cd(fPath); else, try, cd('~/supFunSim/'); catch, warningMessage = 'Problem encoutered while trying to change working directory to ''~/supFunSim/''.'; end; end; disp(['CYBERCRAFT:: pwd is: ',pwd])

run('./tg_s07_BATCH___01_Prelude.m'); whos
SETUP
chkSim___tg_s01_PRE___001(SETUP);
chkSim___tg_s01_PRE___000_PARSE_SETUP(SETUP,sel_atl);
run('./tg_s07_BATCH___02_Signals.m'); whos
run('./tg_s07_BATCH___03_Leadfields.m'); whos

% if BcgNoise (biological background  noise) is to be white Gaussian,
% then please uncomment the following two lines. 
% sim_sig_BcgNoise.sigSRC_pre = randn(size(sim_sig_BcgNoise.sigSRC_pre));
% sim_sig_BcgNoise.sigSRC_pst = randn(size(sim_sig_BcgNoise.sigSRC_pst));
% if one wishes the biological noise on sensors to be white Gaussian
% sim_sig_BcgNoise.sigSNS_pre = randn(size(sim_sig_BcgNoise.sigSNS_pre));
% sim_sig_BcgNoise.sigSNS_pst = randn(size(sim_sig_BcgNoise.sigSNS_pst));

% rawImgSC(squareform(pdist(sim_lfg_SrcActiv_orig.lfg.pos,'euclidean')))

run('./tg_s07_BATCH___04_Preparations.m');    whos

switch SETUP.supSwitch
  case {'rec'}

    % Reconstruction
    disp('Reconstruction')
    run('./tg_s07_BATCH___05_Filters.m'); whos

    % Check the results
    sortrows(rec_res.table,'rec_sigAmp_ErrEuclid_vec')
    sortrows(rec_res.table,'rec_sigAmp_ErrCorrCf_vec','descend')
    sortrows(rec_res.table,'rec_funDep_A00_ErrEuclid_vec')
    sortrows(rec_res.table,'rec_funDep_A00_ErrCorrCf_vec','descend')
    sortrows(rec_res.table,'rec_funDep_PDC_ErrEuclid_vec')
    sortrows(rec_res.table,'rec_funDep_PDC_ErrCorrCf_vec','descend')
    rec_opt.ranks

  case {'loc'}

    % Localization
    disp('Localization')
    run('./tg_s07_BATCH___05_Localizers.m'); whos

  otherwise
    warning('Unexpected supSwitch value. No action taken, only data generated.')
end

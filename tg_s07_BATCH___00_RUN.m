
if exist('fPath'), cd(fPath); else, try, cd('~/supFunSim/'); catch, warningMessage = 'Problem encoutered while trying to change working directory to ''~/supFunSim/''.'; uiwait(msgbox(warningMessage)); warning(warningMessage); end; end; disp(['CYBERCRAFT:: pwd is: ',pwd])

run('./tg_s07_BATCH___01_Prelude.m'); whos
SETUP
chkSim___tg_s01_PRE___001(SETUP);
chkSim___tg_s01_PRE___000_PARSE_SETUP(SETUP,sel_atl);
run('./tg_s07_BATCH___02_Signals.m'); whos

% if BcgNoise ( biological background  noise) is to be white Gaussian,
% then please uncomment the following two lines.
% sim_sig_BcgNoise.sigSRC_pre = randn(size(sim_sig_BcgNoise.sigSRC_pre));
% sim_sig_BcgNoise.sigSRC_pst = randn(size(sim_sig_BcgNoise.sigSRC_pst));

run('./tg_s07_BATCH___03_Leadfields.m'); whos

% if one wishes the biological noise on sensors to be white Gaussian
% sim_sig_BcgNoise.sigSNS_pre = randn(size(sim_sig_BcgNoise.sigSNS_pre));
% sim_sig_BcgNoise.sigSNS_pst = randn(size(sim_sig_BcgNoise.sigSNS_pst));

if 1, SETUP.SINR = 15; end
if 1, SETUP.SBNR = 15; end
if 1, SETUP.SMNR = 15; end

run('./tg_s07_BATCH___04_SNRs.m');    whos
run('./tg_s07_BATCH___05_Filters.m'); whos

% Check the results
sortrows(rec_res.table,'rec_sigAmp_ErrEuclid_vec')
sortrows(rec_res.table,'rec_sigAmp_ErrCorrCf_vec','descend')

sortrows(rec_res.table,'rec_funDep_A00_ErrEuclid_vec')
sortrows(rec_res.table,'rec_funDep_A00_ErrCorrCf_vec','descend')
sortrows(rec_res.table,'rec_funDep_PDC_ErrEuclid_vec')
sortrows(rec_res.table,'rec_funDep_PDC_ErrCorrCf_vec','descend')
rec_opt.ranks

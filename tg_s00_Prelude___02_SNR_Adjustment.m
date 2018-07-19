SETUP.CUBE           = 20;    % perturbation of the leadfields based on the shift of source position within a cube of given edge length (centered at the original leadfields positions)
SETUP.CONE           = pi/32; % perturbation of the leadfields based on the rotation of source orientation (azimuth TH, elevation PHI)
SETUP.H_Src_pert     = 1;     % use original (0) or perturbed (1) leadfield for signal reconstruction
SETUP.H_Int_pert     = 1;     % use original (0) or perturbed (1) leadfield for nulling constrains
SETUP.SINR           = 5;     % signal to interference noise power ratio expressed in dB (both measured on electrode level)
SETUP.SBNR           = 10;    % signal to biological noise power ratio expressed in dB (both measured on electrode level)
SETUP.SMNR           = 15;    % signal to measurment noise power ratio expressed in dB (both measured on electrode level)
SETUP.WhtNoiseAddFlg = 1;     % white noise admixture in biological noise interference noise (FLAG)
SETUP.WhtNoiseAddSNR = 3;     % SNR of BcgNoise and WhiNo (dB)
SETUP.SigPre = 0;   SETUP.IntPre = 0;   SETUP.BcgPre = 1;   SETUP.MesPre = 1; % final signal components for pre-interval  (use zero or one for signal, interference noise, biological noise, measurement noise)
SETUP.SigPst = 1;   SETUP.IntPst = 1;   SETUP.BcgPst = 1;   SETUP.MesPst = 1; % final signal components for post-interval (as above)

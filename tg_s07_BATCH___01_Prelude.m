
fPath='/home/metalipa/supFunSim/';

% Tidy up and change working directory.
clc; close all;clearvars('-except','fPath');
if exist('fPath'),cd(fPath);else,try,cd('~/cc_overkill/git/supFunSim');catch,cd('~/supFunSim');end;end;
clear all;
close all;
clc;

run('./tg_s00_Prelude___01_Simulations_main_setup.m')
run('./tg_s00_Prelude___02_SNR_Adjustment.m')

% Rows of SETUP.SRCS reppresent ROIs.
% Cols of SETUP.SRCS represent SrcActiv, IntNoise and BcgNoise, respectively.
SETUP.SRCS   = [];
SETUP.SRCS   = [ SETUP.SRCS; 4 3 0 ];
SETUP.SRCS   = [ SETUP.SRCS; 3 3 1 ];
SETUP.SRCS   = [ SETUP.SRCS; 2 3 0 ];
SETUP.SRCS   = [ SETUP.SRCS; 2 3 2 ];
SETUP.SRCS   = [ SETUP.SRCS; 2 3 0 ];
SETUP.SRCS   = [ SETUP.SRCS; 0 3 0 ];
SETUP.SRCS   = [ SETUP.SRCS; 0 3 0 ];
SETUP.SRCS   = [ SETUP.SRCS; 0 3 2 ];
SETUP.SRCS   = [ SETUP.SRCS; 0 3 2 ];
SETUP.DEEP   = [             0 0 20 ]; % deep sources

SETUP.ERPs   = 0;       % Add ERPs (timelocked activity)

SETUP.rROI   = 1;       % random (1) or predefined (0) ROIs


% Basic setting s for sources and noise.
SETUP.n00    = 500;     % number of time samples per trial
SETUP.K00    = 1;      % number of independent realizations of signal and noise based on generated MVAR model
SETUP.P00    = 6;       % order of the MVAR model used to generate time-courses for signal of interest
SETUP.FRAC   = 0.20;    % proportion of ones to zeros in off-diagonal elements of the MVAR coefficients masking array
SETUP.STAB   = 0.99;    % MVAR stability limit for MVAR eigenvalues (less than 1.0 results in more stable model producing more stationary signals)
SETUP.RNG    = [0,2.8]; % range for pseudo-random sampling of eigenvalues for MVAR coefficients range

% Settings controlling how informative the code execution should be.
% By default most of the output text, plot, checkup and other features is turned off for the batch simulations!!!
SETUP.ITER   = 5e5;     % iterations limit for MVAR pseudo-random sampling and stability verification
SETUP.PDC_RES = [0:0.01:0.5]; % resolution vector for normalized PDC estimation
SETUP.TELL   = 0;       % provide additional comments during code execution ("tell me more")
SETUP.PLOT   = 0;       % plot figures during the intermediate stages
SETUP.SCRN   = get(0,'MonitorPositions'); % get screens positions
SETUP.DISP   = SETUP.SCRN(end,:);        % force figures to be displayed on (3dr) screenscreen

% Settings for seed selection
tmp_shoudSeedBeFixed = 0;
if tmp_shoudSeedBeFixed,SETUP.SEED = rng(1964);else,SETUP.SEED = rng(round(1e3*randn()^2*sum(clock)));end
clearvars ii jj kk nn tmp*

% OK
SETUP.RANK_EIG = sum(SETUP.SRCS(:,1)); % rank of EIG-LCMV filter: set to number of active sources
SETUP.fltREMOVE = 1; %to keep (0) or remove (1) selected filters
SETUP.SHOWori = 0; % to show (1) or do not show (0) Original and Dummy signals on Figures
SETUP.IntLfgRANK = round(0.3*sum(SETUP.SRCS(:,2))); % rank of patch-constrained reduced-rank leadfield

% Leadfields perturbation settings.
SETUP.CUBE           = 20;    % perturbation of the leadfields based on the shift of source position within a cube of given edge length (centered at the original leadfields positions)
SETUP.CONE           = pi/32; % perturbation of the leadfields based on the rotation of source orientation (azimuth TH, elevation PHI)
SETUP.H_Src_pert     = 0;     % use original (0) or perturbed (1) leadfield for signal reconstruction
SETUP.H_Int_pert     = 0;     % use original (0) or perturbed (1) leadfield for nulling constrains
SETUP.SINR           = 0;     % signal to interference noise power ratio expressed in dB (both measured on electrode level)
SETUP.SBNR           = 0;     % signal to biological noise power ratio expressed in dB (both measured on electrode level)
SETUP.SMNR           = 20;    % signal to measurment noise power ratio expressed in dB (both measured on electrode level)
SETUP.WhtNoiseAddFlg = 1;     % white noise admixture in biological noise interference noise (FLAG)
SETUP.WhtNoiseAddSNR = 3;     % SNR of BcgNoise and WhiNo (dB)

% Components of the final signals for "PRE" and "POST" portion.
SETUP.SigPre = 0;   SETUP.IntPre = 0;   SETUP.BcgPre = 1;   SETUP.MesPre = 1; % final signal components for pre-interval  (use zero or one for signal, interference noise, biological noise, measurement noise)
SETUP.SigPst = 1;   SETUP.IntPst = 1;   SETUP.BcgPst = 1;   SETUP.MesPst = 1; % final signal components for post-interval (as above)

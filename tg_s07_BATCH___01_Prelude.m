fPath='/home/metalipa/supFunSim_KIS_RECONSTRUCTION_VERSION_ORIGIN_KIS/';

% Tidy up and change working directory.
clc; close all;clearvars('-except','fPath');
if exist('fPath'),cd(fPath);else,try,cd('~/cc_overkill/git/supFunSim');catch,cd('~/supFunSim');end;end;
clear all;
close all;
clc;

run('./tg_s00_Prelude___01_Simulations_main_setup.m')
run('./tg_s00_Prelude___02_SNR_Adjustments.m')

% Rows of SETUP.SRCS reppresent ROIs.
% Cols of SETUP.SRCS represent SrcActiv, IntNoise and BcgNoise, respectively.
SETUP.rROI   = logical(1);       % random (1) or predefined (0) ROIs
SETUP.rPNT   = logical(0);       % random (1) or predefined (0) candidate points for source locations: if 0, 
				 % number of sources as in SETUP.SRCS(1,1) will be fixed and in close locations
SETUP.SRCS   = []; % Cortical sources (avoid placing more than 10 sources in single ROI)
SETUP.SRCS   = [ SETUP.SRCS;  3  0  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  3  0  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  3  1  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  4  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  4  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  4  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  4  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  0  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  0  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  0  3 ];
SETUP.DEEP   = [              0  1  6 ]; % deep sources

SETUP.ERPs   = 0;       % Add ERPs (timelocked activity)

% Basic setting s for sources and noise.
SETUP.n00    = 500;     % number of time samples per trial
SETUP.K00    = 1;       % number of independent realizations of signal and noise based on generated MVAR model
			% note: covariance matrix R of observed signal and noise covariance matrix N are
			% estimated from samples originating from all realizations of signal and noise
SETUP.FIXED_SEED = 1; % Settings for seed selection
if SETUP.FIXED_SEED, SETUP.SEED = rng(1964);else,SETUP.SEED = rng(round(1e3*randn()^2*sum(clock)));end
SETUP.RANK_EIG = sum(SETUP.SRCS(:,1)); % rank of EIG-LCMV filter: set to number of active sources
SETUP.fltREMOVE = 1;    % to keep (0) or remove (1) selected filters
SETUP.SHOWori = 0; % to show (1) or do not show (0) Original and Dummy signals on Figures
SETUP.IntLfgRANK = round(0.3*sum(SETUP.SRCS(:,2))); % rank of patch-constrained reduced-rank leadfield
SETUP.supSwitch = 'rec'; % 'rec': run reconstruction of sources activity, 'loc': find active sources

SETUP.SINR           = 0;     % signal to interference noise power ratio expressed in dB (both measured on electrode level)
SETUP.SBNR           = 0;    % signal to biological noise power ratio expressed in dB (both measured on electrode level)
SETUP.SMNR           = 0;    % signal to measurment noise power ratio expressed in dB (both measured on electrode level)
SETUP.WhtNoiseAddFlg = 1;     % white noise admixture in biological noise interference noise (FLAG)
SETUP.WhtNoiseAddSNR = 3;     % SNR of BcgNoise and WhiNo (dB)
SETUP.SigPre = 0;   SETUP.IntPre = 0;   SETUP.BcgPre = 1;   SETUP.MesPre = 1; % final signal components for pre-interval  (use zero or one for signal, interference noise, biological noise, measurement noise)
SETUP.SigPst = 1;   SETUP.IntPst = 1;   SETUP.BcgPst = 1;   SETUP.MesPst = 1; % final signal components for post-interval (as above)

% For localization, the default is to consider random locations of ROI with some fixed candidate points such that 
% SETUP.SRCS(1,1) of them are in close locations; additionally, no interfering sources are considered
% in the localization model. You may comment out the 'if' section below to experiment with other settings.
if(SETUP.supSwitch == 'loc') 
    SETUP.rROI   = logical(1);       % random (1) or predefined (0) ROIs
    SETUP.rPNT   = logical(0);       % random (1) or predefined (0) candidate points for source locations: if 0, 
				     % number of sources as in SETUP.SRCS(1,1) will be fixed and in close locations
    SETUP.SigPre = 0;   SETUP.IntPre = 0;   SETUP.BcgPre = 1;   SETUP.MesPre = 1; % final signal components for pre-interval  (use zero or one for signal, interference noise, biological noise, measurement noise)
    SETUP.SigPst = 1;   SETUP.IntPst = 0;   SETUP.BcgPst = 1;   SETUP.MesPst = 1; % final signal components for post-interval (as above)
end

if SETUP.rPNT
    disp('CC: using random source locations')
else
    disp('CC: using predefined source locations')
end

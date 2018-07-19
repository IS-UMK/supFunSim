fPath='/home/metalipa/supFunSim_KIS_RECONSTRUCTION_VERSION_ORIGIN_KIS/';

% Tidy up workspace and change working directory
clc; close all;clearvars('-except','fPath');
if exist('fPath'), cd(fPath); else, try, cd('~/supFunSim/'); catch, warningMessage = 'Problem encoutered while trying to change working directory to ''~/supFunSim/''.'; uiwait(msgbox(warningMessage)); warning(warningMessage); end; end; disp(['CYBERCRAFT:: pwd is: ',pwd])

% Add path to additional functions
addpath([pwd,'/fun']);

% Add path to toolboxes
if 0, disp('COMMENT: if having problems with toolboxes consider wise use of:'); restoredefaultpath; end
clearvars TMP_TOOLB_PATH; if exist('~/toolboxes/','dir') == 7, TMP_TOOLB_PATH = '~/toolboxes/'; else, warningMessage = sprintf('CYBERCRAFT:: Warning:: toolboxes directory was not found (use ''~/toolboxes/'')'); uiwait(msgbox(warningMessage)); warning(warningMessage); end; if exist('TMP_TOOLB_PATH','var'), disp(['CYBERCRAFT:: looking for toolboxes in: ',TMP_TOOLB_PATH]), end;
addpath([TMP_TOOLB_PATH,'/arfit']);
addpath([TMP_TOOLB_PATH,'/mvarica']);
addpath([TMP_TOOLB_PATH,'spm12/']);
addpath([TMP_TOOLB_PATH,'spm12/toolbox/aal/']);
addpath([TMP_TOOLB_PATH,'eeglab/']);
addpath([TMP_TOOLB_PATH,'fieldtrip/']); ft_defaults;
if exist([TMP_TOOLB_PATH,'fieldtrip/privatePublic/',filesep]),         addpath([TMP_TOOLB_PATH,'fieldtrip/privatePublic/',filesep]);         else, copyfile([TMP_TOOLB_PATH,'fieldtrip/private/',filesep],        [TMP_TOOLB_PATH,'fieldtrip/privatePublic/',filesep]);         addpath([TMP_TOOLB_PATH,'fieldtrip/privatePublic/',filesep]);         end;
if exist([TMP_TOOLB_PATH,'fieldtrip/forward/privatePublic/',filesep]), addpath([TMP_TOOLB_PATH,'fieldtrip/forward/privatePublic/',filesep]); else, copyfile([TMP_TOOLB_PATH,'fieldtrip/forward/private/',filesep],[TMP_TOOLB_PATH,'fieldtrip/forward/privatePublic/',filesep]); addpath([TMP_TOOLB_PATH,'fieldtrip/forward/privatePublic/',filesep]); end;
addpath([TMP_TOOLB_PATH,'fieldtrip/utilities']);
if exist([TMP_TOOLB_PATH,'fieldtrip/utilities/privatePublic/',filesep]), addpath([TMP_TOOLB_PATH,'fieldtrip/utilities/privatePublic/',filesep]); else, copyfile([TMP_TOOLB_PATH,'fieldtrip/utilities/private/',filesep],[TMP_TOOLB_PATH,'fieldtrip/utilities/privatePublic/',filesep]); addpath([TMP_TOOLB_PATH,'fieldtrip/utilities/privatePublic/',filesep]); end;

% Load head geometry, electrode positions and ROIs data.
load('./mat/sel_msh.mat');                     % head compartments geometry (cortex)
load('./mat/sel_geo_deep_thalami.mat');        % mesh containing candidates for lacation of deep sources (based on thalami)
load('./mat/sel_geo_deep_icosahedron642.mat'); % mesh containing candidates for lacation of deep sources (based on icosahedron642)
load('./mat/sel_atl.mat');                     % cortex geometry with (anatomical) ROI parcellation
load('./mat/sel_vol.mat');                     % volume conduction model (head-model)
load('./mat/sel_ele.mat');                     % geometry of electrode positions

clearvars ii jj kk mm nn tmp* SETUP

% Simulations main setup
SETUP.SRCS   = []; % Cortical sources (avoid placing more than 10 sources in single ROI)
SETUP.SRCS   = [ SETUP.SRCS;  2  0  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  2  0  0 ];
SETUP.SRCS   = [ SETUP.SRCS;  2  1  0 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  4  0 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  4  0 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  4  0 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  4  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  0  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  0  3 ];
SETUP.SRCS   = [ SETUP.SRCS;  0  0  3 ];
SETUP.DEEP   = [              2  1  6 ]; % deep sources
SETUP.ERPs   = 5;       % Add ERPs (timelocked activity)
SETUP.rROI   = 0;       % random (1) or predefined (0) ROIs
SETUP.ELEC   = size(sel_ele.elecpos,1); % number of electrodes
SETUP.n00    = 500;     % number of time samples per trial
SETUP.K00    = 50;      % number of independent realizations of signal and noise based on generated MVAR model
SETUP.P00    = 6;       % order of the MVAR model used to generate time-courses for signal of interest
SETUP.FRAC   = 0.20;    % proportion of ones to zeros in off-diagonal elements of the MVAR coefficients masking array
SETUP.STAB   = 0.99;    % MVAR stability limit for MVAR eigenvalues (less than 1.0 results in more stable model producing more stationary signals)
SETUP.RNG    = [0,2.8]; % range for pseudo-random sampling of eigenvalues for MVAR coefficients range
SETUP.ITER   = 5e5;     % iterations limit for MVAR pseudo-random sampling and stability verification
SETUP.PDC_RES = [0:0.01:0.5]; % resolution vector for normalized PDC estimation
SETUP.TELL   = 1;       % provide additional comments during code execution ("tell me more")
SETUP.PLOT   = 1;       % plot figures during the intermediate stages
SETUP.SCRN   = get(0,'MonitorPositions'); % get screens positions
SETUP.DISP   = SETUP.SCRN(end,:);        % force figures to be displayed on (3dr) screenscreen
SETUP.SEED   = rng(round(1e3*randn()^2*sum(clock)));
SETUP.RANK_EIG = sum(SETUP.SRCS(:,1)); % rank of EIG-LCMV filter: set to number of active sources
SETUP.fltREMOVE = 1; % to keep (0) or remove (1) selected filters
SETUP.SHOWori = 1; % to show (1) or do not show (0) Original and Dummy signals on Figures
SETUP.IntLfgRANK = round(0.3*sum(SETUP.SRCS(:,2))); % rank of patch-constrained reduced-rank leadfield

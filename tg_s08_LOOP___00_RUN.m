if exist('fPath'), cd(fPath); else, try, cd('~/supFunSim/'); catch, warningMessage = 'Problem encoutered while trying to change working directory to ''~/supFunSim/''.'; end; end; disp(['CYBERCRAFT:: pwd is: ',pwd])

clearvars ii jj kk nn tmp* LOOP* Loop*;
run('./tg_s07_BATCH___01_Prelude.m');
SETUP

% Get some details for simulation output filename (*.mat file)
LOOP.DATE = datestr(now,'yyyymmdd_HHMMSS');
LOOP.NAME = tempname; [~, LOOP.NAME] = fileparts(LOOP.NAME); % simulation unique name

% Number of simulation runs for each SNRs combination
LOOP.totSimCount = 10;
LOOP.rngSimCount = 1:LOOP.totSimCount;

% Range of SNRs 
LOOP.rngMesNoise = 0;
LOOP.rngBcgNoise = [-10:10:10];
LOOP.rngIntNoise = 0;

LOOP
SETUP

run('./tg_s08_LOOP___01_Main_LOOP.m'); whos

switch SETUP.supSwitch
  case {'rec'}

    run('./tg_s08_Loop_Reconstruction_Plot___02_.m')

  case {'loc'}

    run('./tg_s08_Loop_Localization_Plot___02_.m')

  otherwise
    warning('Unexpected supSwitch value. No action taken, only data generated.')
end

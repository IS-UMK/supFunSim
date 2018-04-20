
if exist('fPath'), cd(fPath); else, try, cd('~/supFunSim/'); catch, warningMessage = 'Problem encoutered while trying to change working directory to ''~/supFunSim/''.'; uiwait(msgbox(warningMessage)); warning(warningMessage); end; end; disp(['CYBERCRAFT:: pwd is: ',pwd])

clearvars ii jj kk nn tmp* LOOP* Loop*;
run('./tg_s07_BATCH___01_Prelude.m');
SETUP

% Get some details for simulation output filename (*.mat file)
LOOP.DATE = datestr(now,'yyyymmdd_HHMMSS');
LOOP.NAME = tempname; [~, LOOP.NAME] = fileparts(LOOP.NAME); % simulation unique name

% Number of simulation runs for each SNRs combination
LOOP.totSimCount = 2;
LOOP.rngSimCount = 1:LOOP.totSimCount;

% Range of SNRs (defaults are consequently [20], [0] and [0,10,20])
LOOP.rngMesNoise = 10;
LOOP.rngBcgNoise = 0;
LOOP.rngIntNoise = [0:10:20];

LOOP
SETUP

run('./tg_s08_LOOP___01_Main_LOOP.m'); whos

LOOP
LOOP.table_varN'
LOOP.table_rowN
size(LOOP.table_arrC)

LOOP.table_arrC_avgSimCount = squeeze(mean(LOOP.table_arrC,3))
LOOP.table_arrC_stdSimCount = squeeze(std(LOOP.table_arrC,[],3))
size(LOOP.table_arrC_avgSimCount)

% PLOT THE RESULTS
mySave = ['./res___',LOOP.DATE,'___',LOOP.NAME,'___',datestr(now,'yyyymmdd_HHMMSS')];
save(mySave)
LOOP

close all
for ii = 1:length(LOOP.table_varN)
    LOOP.table_varN'
    tmp_pickVar = ii;
    disp(LOOP.table_varN(tmp_pickVar))

    TMP_res.table_arrC = squeeze(LOOP.table_arrC_avgSimCount(:,tmp_pickVar,:))
    TMP_res.table_varN = strrep(strrep(strsplit(num2str(LOOP.(LOOP.NamNoise),'%+d ')),'-','n'),'+','p')
    TMP_res.table_rowN = LOOP.table_rowN
    TMP_res.table = array2table(TMP_res.table_arrC,'VariableNames',TMP_res.table_varN,'RowNames',TMP_res.table_rowN);
    sortrows(TMP_res.table,1)

    figure('Name',[LOOP.table_varN{tmp_pickVar},' for ',LOOP.NamNoise,' in ',num2str(LOOP.(LOOP.NamNoise),'%+d ')])
    bar(TMP_res.table_arrC)
    set(gca, 'XTick', 1:length(TMP_res.table_rowN), 'XTickLabel', strrep(TMP_res.table_rowN,'_','\_'));
    h1 = legend(strsplit(num2str(LOOP.(LOOP.NamNoise),'%+d ')))
    myTitle = strrep([LOOP.table_varN{tmp_pickVar},' for ',LOOP.NamNoise,' in ',num2str(LOOP.(LOOP.NamNoise),'%+d ')],'_','\_');
    % title(myTitle)
    myName = ['./fig/',LOOP.DATE,'___',LOOP.NAME,'___fig_',num2str(ii),'___',strrep(strrep(myTitle,'\',''),' ','_')];

    v1 = get(h1,'title')
    set(v1,'string','SINR')

    set(gcf, 'PaperUnits', 'centimeters')
    set(gcf, 'PaperOrientation', 'portrait')
    set(gcf, 'PaperSize', [20, 20])
    set(gcf, 'Position', [100, 100, 800, 750])
    legend('Location','northeastoutside')
    xtickangle(45)

    savefig(gcf,myName,'compact')
    savefig(gcf,myName)
    saveas(gcf,myName,'pdf')
end

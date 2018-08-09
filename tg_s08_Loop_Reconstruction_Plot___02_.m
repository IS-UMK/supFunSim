LOOP
LOOP.table_varN'
LOOP.table_rowN
size(LOOP.table_arrC)

LOOP.table_arrC_avgSimCount = squeeze(mean(LOOP.table_arrC,3))
LOOP.table_arrC_stdSimCount = squeeze(std(LOOP.table_arrC,[],3))
size(LOOP.table_arrC_avgSimCount)

% SAVE THE RESULTS
mySave = ['./res___',LOOP.DATE,'___',LOOP.NAME,'___',datestr(now,'yyyymmdd_HHMMSS')];
save(mySave)
LOOP
% remove done filters from plot (for good)
myRem = not(ismember(LOOP.table_rowN,{'ZF','Dummy','ZEROS'}))
LOOP.table_rowN = LOOP.table_rowN(myRem,:)
LOOP.table_arrC_avgSimCount = LOOP.table_arrC_avgSimCount(myRem,:,:)
LOOP.table_arrC_stdSimCount = LOOP.table_arrC_stdSimCount(myRem,:,:)
LOOP.table_arrC = LOOP.table_arrC(myRem,:,:,:,:,:)

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

    % fix me: it does not have to be SINR
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

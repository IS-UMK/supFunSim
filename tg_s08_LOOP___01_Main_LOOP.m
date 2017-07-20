[LOOP.c01RR,LOOP.c02MM,LOOP.c03BB,LOOP.c04II] = ndgrid(LOOP.rngSimCount,LOOP.rngMesNoise,LOOP.rngBcgNoise,LOOP.rngIntNoise);
LOOP.coords = [LOOP.c01RR(:),LOOP.c02MM(:),LOOP.c03BB(:),LOOP.c04II(:)];

2 == length(size(squeeze(double.empty([[length(LOOP.rngMesNoise),length(LOOP.rngBcgNoise),length(LOOP.rngIntNoise)],0]))))
if 2 == length(size(squeeze(double.empty([[length(LOOP.rngMesNoise),length(LOOP.rngBcgNoise),length(LOOP.rngIntNoise)],0]))))
    if max([length(LOOP.rngMesNoise),length(LOOP.rngBcgNoise),length(LOOP.rngIntNoise)]) == min([length(LOOP.rngMesNoise),length(LOOP.rngBcgNoise),length(LOOP.rngIntNoise)]),
        LOOP.IdxNoise = 0;
    else,
        [~,LOOP.IdxNoise] = max([length(LOOP.rngMesNoise),length(LOOP.rngBcgNoise),length(LOOP.rngIntNoise)]);
    end;
    if LOOP.IdxNoise == 1,
        LOOP.NamNoise = 'rngMesNoise';
    elseif LOOP.IdxNoise == 2,
        LOOP.NamNoise = 'rngBcgNoise';
    elseif LOOP.IdxNoise == 3,
        LOOP.NamNoise = 'rngIntNoise';
    else,
        LOOP.NamNoise = 'AnyNoise';
    end;
else,
    error('CYBERCRAFT:: ensure that only one noise type is vector and the remaining are scalars');
end;
LOOP.iterations = []; LOOP.progress = []; LOOP.table_arrC = []; LOOP.table_varN = {}; LOOP.table_rowN = {};

for LoopSimCount = 1:LOOP.totSimCount
    run('./tg_s07_BATCH___02_Signals.m');
    run('./tg_s07_BATCH___03_Leadfields.m');
    for LoopIntNoise = 1:length(LOOP.rngIntNoise)
        for LoopBcgNoise = 1:length(LOOP.rngBcgNoise)
            for LoopMesNoise = 1:length(LOOP.rngMesNoise)

                LOOP.iterations = [LOOP.iterations;LoopSimCount,LoopMesNoise,LoopBcgNoise,LoopIntNoise];
                LOOP.progress   = [LOOP.progress;LoopSimCount,LOOP.rngMesNoise(LoopMesNoise),LOOP.rngBcgNoise(LoopBcgNoise),LOOP.rngIntNoise(LoopIntNoise)];
                fprintf('\n');
                disp('============================')
                disp(['CurrIter: ',num2str(size(LOOP.progress,1)),' of ',num2str(length(LOOP.coords))])
                disp('----------------------------')
                disp(['SimCount: ',num2str(LoopSimCount),' of ',num2str(LOOP.totSimCount)])
                disp(['MesNoise: ',num2str(LoopMesNoise),' of ',num2str(length(LOOP.rngMesNoise)),' (',num2str(LOOP.rngMesNoise(LoopMesNoise)),' dB in ' ,'[ ',num2str(LOOP.rngMesNoise),' ])'])
                disp(['BcgNoise: ',num2str(LoopBcgNoise),' of ',num2str(length(LOOP.rngBcgNoise)),' (',num2str(LOOP.rngBcgNoise(LoopBcgNoise)),' dB in ' ,'[ ',num2str(LOOP.rngBcgNoise),' ])'])
                disp(['IntNoise: ',num2str(LoopIntNoise),' of ',num2str(length(LOOP.rngIntNoise)),' (',num2str(LOOP.rngIntNoise(LoopIntNoise)),' dB in ' ,'[ ',num2str(LOOP.rngIntNoise),' ])'])
                disp('----------------------------')
                disp(['SETUP.n00: ',num2str(SETUP.n00)])
                disp(['SETUP.K00: ',num2str(SETUP.K00)])
                % chkSim___tg_s01_PRE___001(SETUP)
                disp('============================')
                SETUP.SINR    = LOOP.rngIntNoise(LoopIntNoise);
                SETUP.SBNR    = LOOP.rngBcgNoise(LoopBcgNoise);
                SETUP.SMNR    = LOOP.rngMesNoise(LoopMesNoise);
                if 1
                    run('./tg_s07_BATCH___04_SNRs.m');
                    run('./tg_s07_BATCH___05_Filters.m');
                    LOOP.table_rowN{size(LOOP.progress,1)} = rec_res.table_rowN;
                    LOOP.table_varN{size(LOOP.progress,1)} = rec_res.table_varN;
                    LOOP.table_arrC(:,:,LoopSimCount,LoopMesNoise,LoopBcgNoise,LoopIntNoise) = rec_res.table_arrC;
                end
            end
        end
    end
end
if isequal(LOOP.table_rowN{:}), LOOP.table_rowN = LOOP.table_rowN{1}; else, error('CYBERCRAFT:: row names are inconsistent'); end;
if isequal(LOOP.table_varN{:}), LOOP.table_varN = LOOP.table_varN{1}; else, error('CYBERCRAFT:: var names are inconsistent'); end;

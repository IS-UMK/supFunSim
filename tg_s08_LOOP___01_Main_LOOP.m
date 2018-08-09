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
LOOP.progress = []; LOOP.table_arrC = []; LOOP.table_varN = {}; LOOP.table_rowN = {};

for LoopSimCount = 1:LOOP.totSimCount
    LoopIterCount = [];      
    run('./tg_s07_BATCH___02_Signals.m');
    run('./tg_s07_BATCH___03_Leadfields.m');
    for LoopIntNoise = 1:length(LOOP.rngIntNoise)
	for LoopBcgNoise = 1:length(LOOP.rngBcgNoise)
	    for LoopMesNoise = 1:length(LOOP.rngMesNoise)

		% used by localization
		LoopIterCount = [LoopIterCount;LoopMesNoise,LoopBcgNoise,LoopIntNoise];
		% used by reconstruction 
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

		run('./tg_s07_BATCH___04_Preparations.m');

		switch SETUP.supSwitch
		  case {'rec'}

		    % Reconstruction
		    disp('Reconstruction')

		    run('./tg_s07_BATCH___05_Filters.m');

		    % removes Original and Dummy signals from Figures
		    if(SETUP.SHOWori==0)
			rec_res.table_rowN = rec_res.table_rowN(3:end);
			rec_res.table_arrC = rec_res.table_arrC(3:end,:);
		    end

		    LOOP.table_rowN{size(LOOP.progress,1)} = rec_res.table_rowN;
		    LOOP.table_varN{size(LOOP.progress,1)} = rec_res.table_varN;
		    LOOP.table_arrC(:,:,LoopSimCount,LoopMesNoise,LoopBcgNoise,LoopIntNoise) = rec_res.table_arrC;

		  case {'loc'}

		    % Localization
		    disp('Localization')

		    run('tg_s07_BATCH___05_Localizers.m');

		    % use LOOP.RES.ITERATION{x}{y}(z) to access results struct for 
		    % z-th activity index (z=1,2,...,8 with z=1 for MAI(2011) etc., as defined in !run MAI and MPZ Locallizers) 
		    % y-th level of SNR of type considered (interference, biological, measurement)
		    % x-th iteration of the experiment
		    LOOP.RES.ITERATION{LoopSimCount}{size(LoopIterCount,1)} = RES;

		    % temporary helper code
		    % save(['RES__','ITERATION_',num2str(LoopSimCount),'__SINR_',num2str(SETUP.SINR),'__SBNR_',num2str(SETUP.SBNR),'__SMNR_',num2str(SETUP.SMNR)],'RES')

		  otherwise
		    warning('Unexpected supSwitch value. No action taken, only data generated.')
		end
	    end
	end
    end
end

switch SETUP.supSwitch
  case {'rec'}

    if isequal(LOOP.table_rowN{:}), LOOP.table_rowN = LOOP.table_rowN{1}; else, error('CYBERCRAFT:: row names are inconsistent'); end;
    if isequal(LOOP.table_varN{:}), LOOP.table_varN = LOOP.table_varN{1}; else, error('CYBERCRAFT:: var names are inconsistent'); end;

  case {'loc'}

  otherwise
    warning('Unexpected supSwitch value. No action taken, only data generated.')
end

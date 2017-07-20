function chkSim___tg_s01_PRE___001(SETUP)
    fprintf('     \n');
    fprintf('CYBERCRAFT:: Number of signal types per CORTEX ROI:\n\n');
    disp(array2table([[1:size(SETUP.SRCS,1)]',SETUP.SRCS,sum(SETUP.SRCS,2)],'VariableNames',{'ROI','SrcActiv','IntNoise','BcgNoise','TOTAL'}))
    fprintf('     \n');
    fprintf('CYBERCRAFT:: TOTAL number of signals for CORTEX:\n\n');
    disp(array2table([size(SETUP.SRCS,1);sum(SETUP.SRCS(:,1));sum(SETUP.SRCS(:,2));sum(SETUP.SRCS(:,3));sum(sum(SETUP.SRCS(:,1:3)))]','VariableNames',{'ROI','SrcActiv','IntNoise','BcgNoise','TOTAL'}));
    fprintf('     \n');
    fprintf('CYBERCRAFT:: Number of signals for DEEP sources:\n\n');
    disp(array2table([size(SETUP.SRCS,1)+1;sum(SETUP.DEEP(1,1));sum(SETUP.DEEP(1,2));sum(SETUP.DEEP(1,3));sum(SETUP.DEEP(1,1:3))]','VariableNames',{'ROI','SrcActiv','IntNoise','BcgNoise','TOTAL'}));
    fprintf('     \n');
    fprintf('CYBERCRAFT:: TOTAL number of signals for CORTEX and DEEP sources:\n\n');
    disp(array2table([NaN;sum(SETUP.SRCS(:,1))+sum(SETUP.DEEP(1,1));sum(SETUP.SRCS(:,2))+sum(SETUP.DEEP(1,2));sum(SETUP.SRCS(:,3))+sum(SETUP.DEEP(1,3));sum(sum(SETUP.SRCS(:,1:3)))+sum(SETUP.DEEP(1,1:3))]','VariableNames',{'ROI','SrcActiv','IntNoise','BcgNoise','TOTAL'}));
    fprintf('     \n');
    disp(['CYBERCRAFT:: MesNoise: ',num2str(SETUP.ELEC)])
end

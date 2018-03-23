
function chkSim___tg_s02_PRE___001(SETUP)
    fprintf('\n');
    fprintf('CYBERCRAFT:: Perturbation cube:\n\n');
    disp(array2table(SETUP.CUBE,'VariableNames',{'mm'},'RowNames',{'shift distance'}))
    fprintf('\n');
    fprintf('CYBERCRAFT:: Perturbation cone:\n\n');
    disp(array2table([SETUP.CONE,rawRad2Deg(SETUP.CONE)],'VariableNames',{'rad','deg'},'RowNames',{'rotation angle'}));
    fprintf('\n');
    fprintf('CYBERCRAFT:: Ratios for signal to:\n\n');
    disp(array2table([SETUP.SINR;SETUP.SBNR;SETUP.SMNR],'VariableNames',{'SxNR'},'RowNames',{'IntNoise','BcgNoise','MesNoise'}));
    fprintf('\n');
    fprintf('CYBERCRAFT:: Signal components:\n\n');
    disp(array2table([SETUP.SigPre,SETUP.IntPre,SETUP.BcgPre,SETUP.MesPre;SETUP.SigPst,SETUP.IntPst,SETUP.BcgPst,SETUP.MesPst]','VariableNames',{'pre','post'},'RowNames',{'SrcActiv','IntNoise','BcgNoise','MesNoise'}));
    fprintf('\n');
end

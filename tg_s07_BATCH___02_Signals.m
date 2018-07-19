disp('CYBERCRAFT:: Generation of timeseries for bioelectrical activity of interest')
run('./tg_s01_Timeseries___01_SrcActiv.m')

disp('CYBERCRAFT:: Generation of timeseries for bioelectrical interference noise')
run('./tg_s01_Timeseries___02_IntNoise.m')

disp('CYBERCRAFT:: Generation of timeseries for bioelectrical background noise')
run('./tg_s01_Timeseries___03_BcgNoise.m')

disp('CYBERCRAFT:: Measurement noise generation')
run('./tg_s01_Timeseries___04_MesNoise.m')

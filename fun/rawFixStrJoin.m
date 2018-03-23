
function [] = rawFixStrJoin()
    disp('=== Before ===')
    which('strjoin','-all')
    addpath([matlabroot,'/toolbox/matlab/strfun/'])
    disp('=== After ===')
    which('strjoin','-all')
end

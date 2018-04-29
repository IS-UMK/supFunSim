
function [y] = rawAdjTotSNRdB(x01,x02,newSNR)
    y = ((x02 / rawNrm(x02)) * rawNrm(x01)) / (db2pow(0.5*newSNR));
end

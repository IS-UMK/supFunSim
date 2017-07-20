function [y] = rawSNRdB(x1,x2)
% Compute SNR in dB for two random vectors (signal and noise)
    y = 20.*log10(norm(x1,'fro')./norm(x2,'fro'));
end

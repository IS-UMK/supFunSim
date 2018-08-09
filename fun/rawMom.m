function [M] = rawMom(x01,k)
% Compute raw moment of the k-th order for the random vector
    M = mean(x01.^k, 1);
end

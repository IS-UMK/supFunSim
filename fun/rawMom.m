
function [M] = rawMom(x01,k)
% Compute raw moment of the k-th order for the random vector
    M = mean(x01.^k, 1);
    if 0
        mean(x01)
        rawMom(x01,1)
        mean(x01.^1,1)
        1/size(x01,1)*sum(x01.^1,1)
        rawMom(x01,3)
        mean(x01.^3,1)
        1/size(x01,1)*sum(x01.^3,1)
    end
end

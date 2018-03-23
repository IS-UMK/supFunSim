
function [y] = rawNrm(x)
 % Compute norm of the random vector
     y = sqrt(sum(rawMom(x,2),2));
 end

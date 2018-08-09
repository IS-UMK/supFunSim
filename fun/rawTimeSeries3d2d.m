function y = rawTimeSeries3d2d(x)

% y = rawTimeSeries3d2d(x)
% NB.: this function asumes that trials are along third dimention.

    y = reshape(permute(x,[1,3,2]),[],size(x,2),1);

end

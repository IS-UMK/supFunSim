function [y] = rawCartToSph(x)
% Convert cartesian to spherical coordinates (row-wise)
    if ~isempty(x)
        for ii = 1:size(x,1)
            [y(ii,1),y(ii,2),y(ii,3)] = cart2sph(x(ii,1),x(ii,2),x(ii,3));
        end
    else
        y = x;
    end
end

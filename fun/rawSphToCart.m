
function [y] = rawSphToCart(x)
% Convert spherical to cartesian coordinates (row-wise)
    if ~isempty(x)
        for ii = 1:size(x,1)
            [y(ii,1),y(ii,2),y(ii,3)] = sph2cart(x(ii,1),x(ii,2),x(ii,3));
        end
    else
        y=x;
    end
end

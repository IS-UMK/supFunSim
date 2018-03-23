
function [y] = rawHotColdColorMap(x)
% [y] = rawHotColdColorMap(x)
% Suggested rationalization: base/2
    if 0
        x = 255
        y = rawHotColdColorMap(x)
    end
    y = [linspace(0,1,x)',linspace(0,1,x)',linspace(1,1,x)'];
    y = [y;fliplr(flipud(y))];
    % imagesc(permute(y,[1,3,2]))
end

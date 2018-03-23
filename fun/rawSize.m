
function [s] = rawSize(x,varargin)
    if isempty(varargin)
        s = size(x);
    else
       s = [];
       for ii = 1:length(varargin{1})
           s = [s,size(x,ii)];
       end
    end
end

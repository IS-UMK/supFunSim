function [h1,h2] = rawImgSC(mat,varargin)
    h1 = imagesc(mat);
    [x,y] = ndgrid(1:size(mat,2),1:size(mat,1));
    mat = mat';
    if ~isempty(varargin)
        fSize = varargin{1};
    else
       fSize = 18;
    end
    h2 = text(x(:),y(:),strtrim(cellstr(num2str(mat(:),'%.2f'))),'HorizontalAlignment','center','FontSize',fSize);
    if 0
        mat = [reshape(-12:12,5,5);reshape(-12:12,5,5);reshape(-12:12,5,5)]
        figure(17);clf;rawImgSC(mat);colorbar;
    end
end

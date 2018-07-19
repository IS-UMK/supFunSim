function cccSim___rawDispA00(A00)
    rawImgSC(A00,8);
    tmp_base = 255;
    tmp_colorMapMat = rawHotColdColorMap(tmp_base);
    caxis([-max(abs(min(min(A00))),abs(max(max(A00)))) max(abs(min(min(A00))),abs(max(max(A00))))]);
    colormap(tmp_colorMapMat);
    colorbar;
    hold on;
    tmp_stem = 0.5+size(A00,1):size(A00,1):size(A00,2)-0.5;
    tmp_vals = size(A00,1)+0.5*ones(size(tmp_stem));
    stem(tmp_stem,tmp_vals,'Color','k','LineWidth',0.5,'Marker', 'none');
    set(gca,'XTick',[0:size(A00,1):size(A00,2)])
end

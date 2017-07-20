function rawPlotPDC(pdcData,accf)
    tmp_row  = size(pdcData,1);
    tmp_col  = size(pdcData,2);
    tmp_cnt  = 0;
    for i = 1:tmp_row
        for j = 1:tmp_col
            tmp_cnt = tmp_cnt+1;
            subplot(tmp_row,tmp_col,tmp_cnt)
            area(accf,squeeze(pdcData(i,j,:)))
            axis tight
            ylim([0,1])
        end
    end
end

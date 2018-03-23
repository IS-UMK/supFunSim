
function cccSim___rawPlotA00(A00)
    tmp_accf = [0:0.01:0.5];
    rawPlotPDC(abs(PDC(A00,tmp_accf)),tmp_accf);
end

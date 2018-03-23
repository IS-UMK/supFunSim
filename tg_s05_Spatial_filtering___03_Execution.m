
clearvars rec_sig ii jj kk nn tmp*
rec_sig.Original = sim_sig_SrcActiv.sigSRC_pst;
rec_sig.Dummy    = sim_sig_SrcActiv.sigSRC_pre;
tmp_fltFields    = fieldnames(rec_flt);

for nn = 1:length(tmp_fltFields),
    for kk = 1:SETUP.K00,
        rec_sig.(tmp_fltFields{nn})(:,:,kk) = (rec_flt.(tmp_fltFields{nn}) * y_Pst(:,:,kk)')';
    end,
end

clearvars ii jj kk nn tmp*

clearvars ii jj kk nn rec_funDep_A00 rec_funDep_PDC
rec_funDep_A00.Original = sim_sig_SrcActiv.A00;

[~,rec_funDep_A00.Dummy,~,~,~,~] = arfit(sim_sig_SrcActiv.sigSRC_pre,sim_sig_SrcActiv.P00,sim_sig_SrcActiv.P00);

tmp_fltFields    = fieldnames(rec_flt);
for nn = 1:length(tmp_fltFields),[~,rec_funDep_A00.(tmp_fltFields{nn}),~,~,~,~] = arfit(rec_sig.(tmp_fltFields{nn}),SETUP.P00,SETUP.P00);end

tmp_allFields    = fieldnames(rec_funDep_A00);
tmp_accf = [0:0.01:0.5];
for nn = 1:length(tmp_allFields),rec_funDep_PDC.(tmp_allFields{nn}) = abs(PDC(rec_funDep_A00.(tmp_allFields{nn}),tmp_accf));end

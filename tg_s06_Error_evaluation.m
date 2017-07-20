clearvars ii jj kk nn tmp* rec_sigAmp_ErrEuclid
tmp_allFields  = fieldnames(rec_sig);
for nn = 1:length(tmp_allFields),
    rec_sigAmp_ErrEuclid.(tmp_allFields{nn}) = (norm(rec_sig.(tmp_allFields{1})(:) - rec_sig.(tmp_allFields{nn})(:))^2)/length(rec_sig.(tmp_allFields{1})(:));
end

clearvars ii jj kk nn tmp* rec_sigAmp_ErrCorrCf
tmp_allFields  = fieldnames(rec_sig);
for nn = 1:length(tmp_allFields),
    rec_sigAmp_ErrCorrCf.(tmp_allFields{nn}) = corrcoef(rec_sig.(tmp_allFields{1})(:),rec_sig.(tmp_allFields{nn})(:));
    rec_sigAmp_ErrCorrCf.(tmp_allFields{nn}) = rec_sigAmp_ErrCorrCf.(tmp_allFields{nn})(1,end);
end

clearvars ii jj kk nn tmp* rec_funDep_A00_ErrMonday rec_funDep_A00_ErrEuclid
tmp_allFields  = fieldnames(rec_sig);
for nn = 1:length(tmp_allFields)
    rec_funDep_A00_ErrEuclid.(tmp_allFields{nn}) = (norm(rec_funDep_A00.(tmp_allFields{1})(:) - rec_funDep_A00.(tmp_allFields{nn})(:))^2)/length(rec_funDep_A00.(tmp_allFields{1})(:));
    if 0
        rec_funDep_A00_ErrMonday.(tmp_allFields{nn}) = rec_funDep_A00.(tmp_allFields{1}) - rec_funDep_A00.(tmp_allFields{nn});
        rec_funDep_A00_ErrMonday.(tmp_allFields{nn}) = abs(rec_funDep_A00_ErrMonday.(tmp_allFields{nn}));
        rec_funDep_A00_ErrMonday.(tmp_allFields{nn}) = max(rec_funDep_A00_ErrMonday.(tmp_allFields{nn}),[],3);
        rec_funDep_A00_ErrMonday.(tmp_allFields{nn}) = mean(mean(rec_funDep_A00_ErrMonday.(tmp_allFields{nn})));
    end
end

clearvars ii jj kk nn tmp* rec_funDep_A00_ErrCorrCf
tmp_allFields  = fieldnames(rec_sig);
for nn = 1:length(tmp_allFields)
    rec_funDep_A00_ErrCorrCf.(tmp_allFields{nn}) = corrcoef(rec_funDep_A00.(tmp_allFields{1})(:),rec_funDep_A00.(tmp_allFields{nn})(:));
    rec_funDep_A00_ErrCorrCf.(tmp_allFields{nn}) = rec_funDep_A00_ErrCorrCf.(tmp_allFields{nn})(1,end);
end

clearvars ii jj kk nn tmp* rec_funDep_PDC_err rec_funDep_PDC_ErrEuclid
tmp_allFields  = fieldnames(rec_sig);
for nn = 1:length(tmp_allFields)
    rec_funDep_PDC_ErrEuclid.(tmp_allFields{nn}) = (norm(rec_funDep_PDC.(tmp_allFields{1})(:) - rec_funDep_PDC.(tmp_allFields{nn})(:))^2)/length(rec_funDep_PDC.(tmp_allFields{1})(:));
end

clearvars ii jj kk nn tmp*  rec_funDep_PDC_ErrCorrCf
tmp_allFields  = fieldnames(rec_sig);
for nn = 1:length(tmp_allFields)
    rec_funDep_PDC_ErrCorrCf.(tmp_allFields{nn}) = corrcoef(rec_funDep_PDC.(tmp_allFields{1})(:),rec_funDep_PDC.(tmp_allFields{nn})(:));
    rec_funDep_PDC_ErrCorrCf.(tmp_allFields{nn}) = rec_funDep_PDC_ErrCorrCf.(tmp_allFields{nn})(1,end);
end

clearvars ii jj kk nn tmp* rec*vec

rec_sigAmp_ErrEuclid_vec = cellfun(@(fn) rec_sigAmp_ErrEuclid.(fn), fieldnames(rec_sigAmp_ErrEuclid), 'UniformOutput', false);
rec_sigAmp_ErrEuclid_vec = squeeze(vertcat(rec_sigAmp_ErrEuclid_vec{:}));

rec_sigAmp_ErrCorrCf_vec = cellfun(@(fn) rec_sigAmp_ErrCorrCf.(fn), fieldnames(rec_sigAmp_ErrCorrCf), 'UniformOutput', false);
rec_sigAmp_ErrCorrCf_vec = squeeze(vertcat(rec_sigAmp_ErrCorrCf_vec{:}));

rec_funDep_A00_ErrEuclid_vec = cellfun(@(fn) rec_funDep_A00_ErrEuclid.(fn), fieldnames(rec_funDep_A00_ErrEuclid), 'UniformOutput', false);
rec_funDep_A00_ErrEuclid_vec = squeeze(vertcat(rec_funDep_A00_ErrEuclid_vec{:}));

rec_funDep_A00_ErrCorrCf_vec = cellfun(@(fn) rec_funDep_A00_ErrCorrCf.(fn), fieldnames(rec_funDep_A00_ErrCorrCf), 'UniformOutput', false);
rec_funDep_A00_ErrCorrCf_vec = squeeze(vertcat(rec_funDep_A00_ErrCorrCf_vec{:}));

rec_funDep_PDC_ErrEuclid_vec = cellfun(@(fn) rec_funDep_PDC_ErrEuclid.(fn), fieldnames(rec_funDep_PDC_ErrEuclid), 'UniformOutput', false);
rec_funDep_PDC_ErrEuclid_vec = squeeze(vertcat(rec_funDep_PDC_ErrEuclid_vec{:}));

rec_funDep_PDC_ErrCorrCf_vec = cellfun(@(fn) rec_funDep_PDC_ErrCorrCf.(fn), fieldnames(rec_funDep_PDC_ErrCorrCf), 'UniformOutput', false);
rec_funDep_PDC_ErrCorrCf_vec = squeeze(vertcat(rec_funDep_PDC_ErrCorrCf_vec{:}));

clearvars ii jj kk nn tmp* rec_res

if     ~isequal(fieldnames(rec_sigAmp_ErrEuclid),fieldnames(rec_sigAmp_ErrCorrCf))
    error('check fieldnames')
elseif ~isequal(fieldnames(rec_sigAmp_ErrEuclid),fieldnames(rec_funDep_A00_ErrEuclid))
    error('check fieldnames')
elseif ~isequal(fieldnames(rec_sigAmp_ErrEuclid),fieldnames(rec_funDep_A00_ErrCorrCf))
    error('check fieldnames')
elseif ~isequal(fieldnames(rec_sigAmp_ErrEuclid),fieldnames(rec_funDep_PDC_ErrEuclid))
    error('check fieldnames')
elseif ~isequal(fieldnames(rec_sigAmp_ErrEuclid),fieldnames(rec_funDep_PDC_ErrCorrCf))
    error('check fieldnames')
else
    rec_res.table_arrC = [ rec_sigAmp_ErrEuclid_vec,  rec_sigAmp_ErrCorrCf_vec,  rec_funDep_A00_ErrEuclid_vec,  rec_funDep_A00_ErrCorrCf_vec,  rec_funDep_PDC_ErrEuclid_vec,  rec_funDep_PDC_ErrCorrCf_vec];
    rec_res.table_varN = {'rec_sigAmp_ErrEuclid_vec','rec_sigAmp_ErrCorrCf_vec','rec_funDep_A00_ErrEuclid_vec','rec_funDep_A00_ErrCorrCf_vec','rec_funDep_PDC_ErrEuclid_vec','rec_funDep_PDC_ErrCorrCf_vec'};
    rec_res.table_rowN = fieldnames(rec_sigAmp_ErrEuclid);
    rec_res.table = array2table(rec_res.table_arrC,'VariableNames',rec_res.table_varN,'RowNames',rec_res.table_rowN);
end

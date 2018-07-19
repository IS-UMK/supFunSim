clearvars ii jj kk nn tmp* 
     tmp_allFields  = fieldnames(rec_sig);

     for nn = 1:length(tmp_allFields)
         for ii = 1:SETUP.n00
             for jj = 1:SETUP.K00
rec_sig.(tmp_allFields{nn})(ii,:,jj)=rec_sig.(tmp_allFields{nn})(ii,:,jj)/norm(rec_sig.(tmp_allFields{nn})(ii,:,jj));
             end
         end
     end

clearvars ii jj kk nn tmp* rec_sigAmp_ErrEuclid
tmp_allFields  = fieldnames(rec_sig);

for nn = 1:length(tmp_allFields)
    tmp_error = zeros(SETUP.n00,SETUP.K00);
    for ii = 1:SETUP.n00
        for jj = 1:SETUP.K00
            tmp_error(ii,jj)=norm(rec_sig.(tmp_allFields{1})(ii,:,jj)-rec_sig.(tmp_allFields{nn})(ii,:,jj))^2;                  
        end
    end
    rec_sigAmp_ErrEuclid.(tmp_allFields{nn})=mean(mean(tmp_error));
end

clearvars ii jj kk nn tmp* rec_sigAmp_ErrCorrCf
tmp_allFields  = fieldnames(rec_sig);

for nn = 1:length(tmp_allFields)
    tmp_error = zeros(sum(SETUP.SRCS(:,1)),SETUP.K00);
    for kk = 1:sum(SETUP.SRCS(:,1))
        for jj = 1:SETUP.K00
            tmp_x=corrcoef(rec_sig.(tmp_allFields{1})(:,kk,jj),rec_sig.(tmp_allFields{nn})(:,kk,jj));
            tmp_error(kk,jj)=tmp_x(1,end);
        end
    end
    rec_sigAmp_ErrCorrCf.(tmp_allFields{nn}) = mean(mean(tmp_error));
end

clearvars ii jj kk nn tmp* rec_funDep_A00_ErrMonday rec_funDep_A00_ErrEuclid
tmp_allFields  = fieldnames(rec_sig);

for nn = 1:length(tmp_allFields)
    rec_funDep_A00_ErrEuclid.(tmp_allFields{nn}) = (norm(rec_funDep_A00.(tmp_allFields{1}) - rec_funDep_A00.(tmp_allFields{nn}),'fro')^2);
end

clearvars ii jj kk nn tmp* rec_funDep_A00_ErrCorrCf
tmp_allFields  = fieldnames(rec_sig);

for nn = 1:length(tmp_allFields)
    tmp_error = zeros(sum(SETUP.SRCS(:,1)),1);
    for kk = 1:sum(SETUP.SRCS(:,1))
        tmp_x=corrcoef(rec_funDep_A00.(tmp_allFields{1})(kk,:),rec_funDep_A00.(tmp_allFields{nn})(kk,:));
        tmp_error(kk)=tmp_x(1,end);
    end
    rec_funDep_A00_ErrCorrCf.(tmp_allFields{nn}) = mean(tmp_error);
end

clearvars ii jj kk nn tmp* rec_funDep_PDC_err rec_funDep_PDC_ErrEuclid
tmp_allFields  = fieldnames(rec_sig);

for nn = 1:length(tmp_allFields)
    tmp_error = zeros(sum(SETUP.SRCS(:,1)),1);
    for ii = 1:sum(SETUP.SRCS(:,1))
        tmp_error(ii) = norm(squeeze(rec_funDep_PDC.(tmp_allFields{1})(ii,:,:)) - squeeze(rec_funDep_PDC.(tmp_allFields{nn})(ii,:,:)),'fro')^2;
    end
    rec_funDep_PDC_ErrEuclid.(tmp_allFields{nn}) = mean(tmp_error);
end

clearvars ii jj kk nn tmp*  rec_funDep_PDC_ErrCorrCf
tmp_allFields  = fieldnames(rec_sig);

for nn = 1:length(tmp_allFields)
    tmp_error = zeros(sum(SETUP.SRCS(:,1)),1);
    for ii = 1:sum(SETUP.SRCS(:,1))
        tmp_x=corrcoef(reshape(squeeze(rec_funDep_PDC.(tmp_allFields{1})(ii,:,:)),[],1),reshape(squeeze(rec_funDep_PDC.(tmp_allFields{nn})(ii,:,:)),[],1));
        tmp_error(ii)=tmp_x(1,end);
    end
    rec_funDep_PDC_ErrCorrCf.(tmp_allFields{nn}) = mean(tmp_error);
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

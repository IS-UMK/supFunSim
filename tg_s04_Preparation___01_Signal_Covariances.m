clearvars ii jj kk nn tmp*

% clearvars ii jj kk nn tmp*

% Note: in this and subsequent subsections we aim at following closely notation from the paper.

if SETUP.H_Src_pert
    H_Src = sim_lfg_SrcActiv_pert.LFG;
else
    H_Src = sim_lfg_SrcActiv_orig.LFG;
end

if SETUP.H_Int_pert
    H_Int = sim_lfg_IntNoise_pert.LFG;
else
    H_Int = sim_lfg_IntNoise_orig.LFG;
end

% reduced-rank leadfield for patch constraints
[U_H_Int Si_H_Int V_H_Int] = svd(H_Int);

for ii = SETUP.IntLfgRANK+1:size(H_Int,2)
    Si_H_Int(ii,ii)=0;
end

H_Int = U_H_Int*Si_H_Int*V_H_Int';

y_Pre =     SETUP.SigPre*sim_sig_AdjSNRs.SrcActivPre ...
    + SETUP.IntPre*sim_sig_AdjSNRs.IntNoisePre ...
    + SETUP.BcgPre*sim_sig_AdjSNRs.BcgNoisePre ...
    + SETUP.MesPre*sim_sig_AdjSNRs.MesNoisePre;

y_Pst =     SETUP.SigPst*sim_sig_AdjSNRs.SrcActivPst ...
    + SETUP.IntPst*sim_sig_AdjSNRs.IntNoisePst ...
    + SETUP.BcgPst*sim_sig_AdjSNRs.BcgNoisePst ...
    + SETUP.MesPst*sim_sig_AdjSNRs.MesNoisePst;

% background activity (as in Pre segment) in Pst segment
y_PstNoise =     SETUP.SigPre*sim_sig_AdjSNRs.SrcActivPst ...
    + SETUP.IntPre*sim_sig_AdjSNRs.IntNoisePst ...
    + SETUP.BcgPre*sim_sig_AdjSNRs.BcgNoisePst ...
    + SETUP.MesPre*sim_sig_AdjSNRs.MesNoisePst;

N = cov(reshape(permute(y_Pre,[1 3 2]),[],size(y_Pre,2),1));
% N = cov(reshape(permute(y_PstNoise,[1 3 2]),[],size(y_PstNoise,2),1));
R = cov(reshape(permute(y_Pst,[1 3 2]),[],size(y_Pst,2),1));

G = H_Src'*pinv(N)*H_Src;
S = H_Src'*pinv(R)*H_Src;

G_SrcInt = [H_Src H_Int]'*pinv(N)*[H_Src H_Int];
S_SrcInt = [H_Src H_Int]'*pinv(R)*[H_Src H_Int];
C_SrcInt = pinv(S_SrcInt) - pinv(G_SrcInt);

% Estimated C for both regular and nulling filters
C_NL = C_SrcInt(1:size(H_Src,2),1:size(H_Src,2));
C = pinv(S)-pinv(G);

clear U_H_Int Si_H_Int V_H_Int G_SrcInt S_SrcInt C_SrcInt;

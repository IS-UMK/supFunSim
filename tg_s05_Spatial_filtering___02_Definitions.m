
% note: S and G use only H_Src, as we want to recover only activity of interest, not interference 
rec_flt.LCMV_R = pinv(S)*H_Src'*pinv(R);
rec_flt.LCMV_N = pinv(G)*H_Src'*pinv(N);

% As proposed in Hui & Leahy 2010
rec_flt.NL = P_NL*pinv(H_SrcInt'*pinv(R)*H_SrcInt)*H_SrcInt'*pinv(R);

rec_flt.MMSE = C*H_Src'*pinv(R);

rec_flt.MMSE_INT = C_SrcInt(1:size(H_Src,2),:)*H_SrcInt'*pinv(R);

rec_flt.ZF = pinv(H_Src);

rec_flt.RANDN = randn(size(H_Src'));

rec_flt.ZEROS = zeros(size(H_Src'));

rec_flt.EIG_LCMV_R = rec_flt.LCMV_R*P_EIG;
rec_flt.EIG_LCMV_N = rec_flt.LCMV_N*P_EIG;

% not applicable in our case as it assumes access to covariance matrix of interference + background noise + measurement noise, whereas in our case N does not contain interference

rec_flt.sMVP_MSE = P_sMVP_MSE_opt*rec_flt.LCMV_R;
rec_flt.sMVP_R = P_sMVP_R_opt*rec_flt.LCMV_R;
rec_flt.sMVP_N = P_sMVP_N_opt*rec_flt.LCMV_N;

rec_flt.sMVP_NL_MSE = P_sMVP_NL_MSE_opt*pinv(P_sMVP_NL_R*H_Src_R)*P_sMVP_NL_R*pinv(sqrtm(R));
rec_flt.sMVP_NL_R = P_sMVP_NL_R_opt*pinv(P_sMVP_NL_R*H_Src_R)*P_sMVP_NL_R*pinv(sqrtm(R));
rec_flt.sMVP_NL_N = P_sMVP_NL_N_opt*pinv(P_sMVP_NL_N*H_Src_N)*P_sMVP_NL_N*pinv(sqrtm(N));

if(SETUP.fltREMOVE)
    rec_flt = rmfield(rec_flt,'RANDN');
    rec_flt = rmfield(rec_flt,'ZEROS');
end

rawFixStrJoin

clearvars R N C C_NL S G P_* H_* jj;

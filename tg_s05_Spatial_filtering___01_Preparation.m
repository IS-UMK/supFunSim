%  NL filter as proposed in Hui & Leahy 2010
H_SrcInt = [H_Src H_Int];
P_NL = [eye(size(H_Src,2)) zeros(size(H_Src,2),size(H_Int,2))];

%  EIG-LCMV filter
[UR, SiR, ~] = svd(R);
P_EIG = UR(:,1:SETUP.RANK_EIG)*UR(:,1:SETUP.RANK_EIG)';

clear UR SiR;

%  sMVP filters
H_Src_R = pinv(sqrtm(R))*H_Src;
H_Src_N = pinv(sqrtm(N))*H_Src;

%  sMVP_MSE filter
% note: S and G use only H_Src, as we want to recover only activity of interest, not interference
% note: pinv(H_Src_R)*pinv(H_Src_R)' = pinv(S)
K_MSE = pinv(S)-2*C;
[U_K_MSE, W_K_MSE] = eig(K_MSE);
[~, p_K_MSE] = sort(diag(W_K_MSE));
% note: for selecting optimal rank, Theobald's Th. can be used without evaluation of the cost function as is done here
U_K_MSE = U_K_MSE(:,p_K_MSE);
sMVP_MSE_ranks = zeros(1,size(H_Src,2));

for jj = 1:size(H_Src,2)
    sMVP_MSE_ranks(jj) = trace(U_K_MSE(:,1:jj)*U_K_MSE(:,1:jj)'*K_MSE);
end

[~, sMVP_MSE_rank_opt] = min(sMVP_MSE_ranks);
P_sMVP_MSE_opt = U_K_MSE(:,1:sMVP_MSE_rank_opt)*U_K_MSE(:,1:sMVP_MSE_rank_opt)';

rec_opt.ranks.sMVP_MSE = sMVP_MSE_rank_opt;
clear K_MSE U_K_MSE W_K_MSE p_K_MSE sMVP_MSE_ranks sMVP_MSE_rank_opt;

%  sMVP_R filter
% note: S and G use only H_Src, as we want to recover only activity of interest, not interference
% note: pinv(H_Src_R)*pinv(H_Src_R)' = pinv(S)
K_MSE = pinv(S)-2*C;

K_R = K_MSE+2*C;
[U_K_R, W_K_R] = eig(K_R);
[~, p_K_R] = sort(diag(W_K_R));
U_K_R = U_K_R(:,p_K_R);
sMVP_R_ranks = zeros(1,size(H_Src,2));

for jj = 1:size(H_Src,2)
    sMVP_R_ranks(jj) = trace(U_K_R(:,1:jj)*U_K_R(:,1:jj)'*K_MSE);
end

[~, sMVP_R_rank_opt] = min(sMVP_R_ranks);
P_sMVP_R_opt = U_K_R(:,1:sMVP_R_rank_opt)*U_K_R(:,1:sMVP_R_rank_opt)';

rec_opt.ranks.sMVP_R = sMVP_R_rank_opt;
clear K_MSE K_R U_K_R W_K_R p_K_R sMVP_R_ranks;

%  sMVP_N filter
% note: S and G use only H_Src, as we want to recover only activity of interest, not interference
% note: pinv(H_Src_N)*pinv(H_Src_N)' = pinv(G)
K_MSE_N = pinv(G)-C;

K_N = K_MSE_N+C;
[U_K_N, W_K_N] = eig(K_N);
[~, p_K_N] = sort(diag(W_K_N));
U_K_N = U_K_N(:,p_K_N);
sMVP_N_ranks = zeros(1,size(H_Src,2));

for jj = 1:size(H_Src,2)
    sMVP_N_ranks(jj) = trace(U_K_N(:,1:jj)*U_K_N(:,1:jj)'*K_MSE_N);
end

[~, sMVP_N_rank_opt] = min(sMVP_N_ranks);
P_sMVP_N_opt = U_K_N(:,1:sMVP_N_rank_opt)*U_K_N(:,1:sMVP_N_rank_opt)';

rec_opt.ranks.sMVP_N = sMVP_N_rank_opt;
clear K_MSE_N K_N U_K_N W_K_N p_K_N sMVP_N_ranks;

%  sMVP filters
clear H_Src_R H_Src_N;

%  sMVP-NL filters
H_Src_R = pinv(sqrtm(R))*H_Src;
H_Src_N = pinv(sqrtm(N))*H_Src;

H_Int_R = pinv(sqrtm(R))*H_Int;
H_Int_N = pinv(sqrtm(N))*H_Int;

P_sMVP_NL_R = eye(size(H_Int_R,1))-H_Int_R*pinv(H_Int_R);
P_sMVP_NL_N = eye(size(H_Int_N,1))-H_Int_N*pinv(H_Int_N);

%  sMVP_NL_MSE filter
K_NL_MSE = pinv(P_sMVP_NL_R*H_Src_R)*P_sMVP_NL_R*(pinv(P_sMVP_NL_R*H_Src_R))'-2*C_NL;
[U_K_NL_MSE, W_K_NL_MSE] = eig(K_NL_MSE);
[~, p_K_NL_MSE] = sort(diag(W_K_NL_MSE));
% note: for selecting optimal rank, Theobald's Th. can be used without evaluation of the cost function as is done here
U_K_NL_MSE = U_K_NL_MSE(:,p_K_NL_MSE);
sMVP_NL_MSE_ranks = zeros(1,size(H_Src,2));

for jj = 1:size(H_Src,2)
    sMVP_NL_MSE_ranks(jj) = trace(U_K_NL_MSE(:,1:jj)*U_K_NL_MSE(:,1:jj)'*K_NL_MSE);
end

[~, sMVP_NL_MSE_rank_opt] = min(sMVP_NL_MSE_ranks);
P_sMVP_NL_MSE_opt = U_K_NL_MSE(:,1:sMVP_NL_MSE_rank_opt)*U_K_NL_MSE(:,1:sMVP_NL_MSE_rank_opt)';

rec_opt.ranks.sMVP_NL_MSE = sMVP_NL_MSE_rank_opt;
clear K_NL_MSE U_K_NL_MSE W_K_NL_MSE p_K_NL_MSE sMVP_NL_MSE_ranks sMVP_NL_MSE_rank_opt;

%  sMVP_NL_R filter
K_NL_MSE = pinv(P_sMVP_NL_R*H_Src_R)*P_sMVP_NL_R*(pinv(P_sMVP_NL_R*H_Src_R))'-2*C_NL;

%K_NL_R = pinv(P_sMVP_NL_R*H_Src_R)*P_sMVP_NL_R*(pinv(P_sMVP_NL_R*H_Src_R))';
K_NL_R = K_NL_MSE+2*C_NL;
[U_K_NL_R, W_K_NL_R] = eig(K_NL_R);
[~, p_K_NL_R] = sort(diag(W_K_NL_R));
U_K_NL_R = U_K_NL_R(:,p_K_NL_R);
sMVP_NL_R_ranks = zeros(1,size(H_Src,2));

for jj = 1:size(H_Src,2)
    sMVP_NL_R_ranks(jj) = trace(U_K_NL_R(:,1:jj)*U_K_NL_R(:,1:jj)'*K_NL_MSE);
end

[~, sMVP_NL_R_rank_opt] = min(sMVP_NL_R_ranks);
P_sMVP_NL_R_opt = U_K_NL_R(:,1:sMVP_NL_R_rank_opt)*U_K_NL_R(:,1:sMVP_NL_R_rank_opt)';

rec_opt.ranks.sMVP_NL_R = sMVP_NL_R_rank_opt;
clear K_NL_MSE K_NL_R U_K_NL_R W_K_NL_R p_K_NL_R sMVP_NL_R_ranks sMVP_NL_R_rank_opt;

%  sMVP_NL_N filter
K_NL_MSE_N = pinv(P_sMVP_NL_N*H_Src_N)*P_sMVP_NL_N*(pinv(P_sMVP_NL_N*H_Src_N))'-C_NL;

%K_NL_N = pinv(P_sMVP_NL_N*H_Src_N)*P_sMVP_NL_N*(pinv(P_sMVP_NL_N*H_Src_N))';
K_NL_N = K_NL_MSE_N+C_NL;
[U_K_NL_N, W_K_NL_N] = eig(K_NL_N);
[~, p_K_NL_N] = sort(diag(W_K_NL_N));
U_K_NL_N = U_K_NL_N(:,p_K_NL_N);
sMVP_NL_N_ranks = zeros(1,size(H_Src,2));

for jj = 1:size(H_Src,2)
    sMVP_NL_N_ranks(jj) = trace(U_K_NL_N(:,1:jj)*U_K_NL_N(:,1:jj)'*K_NL_MSE_N);
end

[~, sMVP_NL_N_rank_opt] = min(sMVP_NL_N_ranks);
% note the simplified notation for P_N_opt
P_sMVP_NL_N_opt = U_K_NL_N(:,1:sMVP_NL_N_rank_opt)*U_K_NL_N(:,1:sMVP_NL_N_rank_opt)';

rec_opt.ranks.sMVP_NL_N = sMVP_NL_N_rank_opt;
clear K_NL_MSE_N K_NL_N U_K_NL_N W_K_NL_N p_K_NL_N sMVP_NL_N_ranks sMVP_NL_N_rank_opt;

%  sMVP-NL filters
clear H_Int_R H_Int_N;

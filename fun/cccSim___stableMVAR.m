function A00 = cccSim___stableMVAR(S00,P00,M00,set_RNG,set_STAB,set_ITER)
% procedure inspired by function stablemvar that is a part of MVARICA Toolbox.
    if 0
        A00 = cccSim___stableMVAR(S00,P00,M00,set_RNG,set_ITER,set_STAB)
    end
    tmp_iterNow = 0;
    tmp_lambda = Inf;
    while any(abs(tmp_lambda)>set_STAB) && tmp_iterNow < set_ITER
        tmp_V = orth(rand(S00*P00,S00*P00));
        tmp_U = orth(rand(S00*P00,S00*P00));
        lambdatmp = set_RNG(1)+(set_RNG(2)-set_RNG(1))*rand(S00*P00,1);
        tmp_A00 = tmp_V*diag(lambdatmp)*tmp_U';
        A00 = tmp_A00(1:S00,:);
        A00 = A00.*repmat(M00,1,P00); % nulling of some coefficients based on mask
        tmp_lambda = eig([A00; eye((P00-1)*S00) zeros((P00-1)*S00,S00)]);
        tmp_iterNow = tmp_iterNow + 1;
    end
    if tmp_iterNow >=set_ITER
        A0=[];
        error('Could not generate stable MVAR model in given number of iterations (set_ITER)');
    end
    if 0
        S00 = sim_sig00.S00
        P00 = sim_sig00.P00
        w00 = sim_sig00.w00
        C00 = sim_sig00.C00
        n00 = sim_sig00.n00
        K00 = sim_sig00.K00
    end
end

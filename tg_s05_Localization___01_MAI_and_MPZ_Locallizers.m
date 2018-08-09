structure = sel_src.lfg;
% lf is the array of cells containing all leafields within ROI
lf = structure.leadfield; 
% position of sources
pos_Src = sim_lfg_SrcActiv_orig.lfg.pos;
[~, pos_Src_ind]=ismember(pos_Src,structure.pos,'rows');

% Results will be stored in structs with fields: 
% leadfield, source positions, localization error, rank selected
% 1 = MAI(2011), 2 = MAI(2013), 3 = MPZ(2011), 4 = MPZ(2013)
% 5 = MAI_RR_I, 6 = MAI_RR_C, 7 = MPZ_RR_I, 8 = MPZ_RR_C
RES = repmat(struct('H',[],'sources',[]),8,1);

% to be used for the proposed heuristic rank-selection criterion 
% leading eigenvalues of R*pinv(N) are equal to those of C*G0+1
x = sort(eig(R*pinv(N)),'descend');
x = x(1:sum(SETUP.SRCS(:,1)));
% percentage of variance explained
y = x./sum(x);
% percent of explained variance
rs_opt = min(find(cumsum(y)>0.8));

clear x y;      

for i = 1:sum(SETUP.SRCS(:,1))
    tic
    i
    % for REAL WORLD APPLICABLE activity indices, rank is fixed
    RES_tmp = repmat({zeros(length(lf),1)}, 1, 8);
    rs = min([i rs_opt]);

    for k = 1:8

        for j = 1:length(lf)

            h_curr = lf{j};

            % we use H obtained for a given index at previous iteration with respect to i, 
            % starting with null matrix
            h = [RES(k).H h_curr];

            G = h'*pinv(N)*h;
            S = h'*pinv(R)*h;
            T = h'*pinv(R)*N*pinv(R)*h;

            [U D ~] = svd(S);            

            MAI_eigenv = sort(real(eig(G*pinv(S))),'descend');
            MPZ_eigenv = sort(real(eig(S*pinv(T))),'descend');

            if ismember(k,[6 8]) & i>rs_opt
                % Csq is rank-deficient if h = lf{j} matches previously found sources
                Csq = real(sqrtm(pinv(S)-pinv(G)));            
                h2 = h*Csq;

                G2 = h2'*pinv(N)*h2;
                S2 = h2'*pinv(R)*h2;
                T2 = h2'*pinv(R)*N*pinv(R)*h2;

                [U2 D2 ~] = svd(S2);
            end

            % REAL-WORLD APPLICABLE family of indices
            switch k
              case 1
                % MAI(2011) index
                RES_tmp{k}(j) = sum(MAI_eigenv);
              case 2             
                % MAI(2013) index
                RES_tmp{k}(j) = sum(MAI_eigenv(1:rs));
              case 3
                % MPZ(2011) index
                RES_tmp{k}(j) = sum(MPZ_eigenv);    
              case 4
                % MPZ(2013) index
                RES_tmp{k}(j) = sum(MPZ_eigenv(1:rs));
              case 5
                % MAI_RR_I index
                P = U(:,1:rs)*U(:,1:rs)';
                RES_tmp{k}(j) = trace(G*pinv(S)*P);
                clear P;
              case 6
                % MAI_RR_C index
                if i<=rs_opt
                    RES_tmp{k}(j) = RES_tmp{k-1}(j);
                elseif i>rs_opt % in this case rs=rs_opt    
                    P2 = U2(:,1:rs_opt)*U2(:,1:rs_opt)';
                    RES_tmp{k}(j) = trace(G2*pinv(S2)*P2);
                    clear P2;
                end
              case 7
                % MPZ_RR_I index
                P = U(:,1:rs)*U(:,1:rs)';
                RES_tmp{k}(j) = trace(S*pinv(T)*P);
                clear P;                       
              case 8
                % MPZ_RR_C index
                if i<=rs_opt
                    RES_tmp{k}(j) = RES_tmp{k-1}(j);
                elseif i>rs_opt % in this case rs=rs_opt        
                    P2 = U2(:,1:rs_opt)*U2(:,1:rs_opt)';
                    RES_tmp{k}(j) = trace(S2*pinv(T2)*P2);
                    clear P2;
                end
            end

            % explicit clear to emphasize that all matrices 
            % are created anew at each iteration for each j and k
            clear h_curr h G S T Csq h2 G2 S2 T2 U D U2 D2 P P2;

            % below: end of j = 1:length(lf) loop    
        end

        [~, w]=max(RES_tmp{k});
        [dis dis_ind] = pdist2(pos_Src,structure.pos(w,:),'chebychev','Smallest',1);

        % store results
        RES(k).H = [RES(k).H lf{w}];
        RES(k).sources(i).candidate_number = w;
        RES(k).sources(i).rank_opt = rs;
        RES(k).sources(i).source_discovered = dis_ind;
        RES(k).sources(i).distance = dis;

        % below: end of k = 1:8 loop
    end

    % below: end of i = 1:SETUP.RANK_EIG loop            
    toc
end

clear structure lf pos_Src;

for ii = 1:3
    sim_geo.ori_pert{ii} = normr(rawSphToCart(rawCartToSph(sim_geo.ori_orig{ii}) + [SETUP.CONE*0.5*(2*rand(size(sim_geo.ori_pert{ii},1),2)-1),zeros(size(sim_geo.ori_pert{ii},1),1)]));
end
tmp_count = 0;
for ii = 1:3
    for jj = 1:size(sim_geo.pos_pert{ii},1)
        tmp_srcInside = false;
        while ~tmp_srcInside
            tmp_count = tmp_count+1;
            sim_geo.pos_pert{ii}(jj,:) = sim_geo.pos_orig{ii}(jj,:)+SETUP.CUBE*0.5*(2*rand([1,3])-1);
            tmp_srcInside = bounding_mesh(sim_geo.pos_pert{ii}(jj,:),sel_msh.bnd(1).pnt,sel_msh.bnd(1).tri);
        end
    end
end
if SETUP.TELL
    disp(['CYBERCRAFT:: Perturbation took ',tmp_count,' iterations'])
end
clearvars ii jj kk nn tmp*

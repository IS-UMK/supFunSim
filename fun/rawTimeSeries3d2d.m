
function y = rawTimeSeries3d2d(x)

% y = rawTimeSeries3d2d(x)
% NB.: this function asumes that trials are along third dimention.

    y = reshape(permute(x,[1,3,2]),[],size(x,2),1);

    if 0
        x = sim_sig_SrcActiv.sigSRC_pre;
        x = sim_sig_SrcActiv.sigSRC_pst;

        y = rawTimeSeries3d2d(x);

        size(y)
        close all
        figure();plot(y(1:500,:))
        figure();plot(x(1:500,:,1))

        figure();plot(y(501:1000,:))
        figure();plot(x(1:500,:,2))

        size(y)

        size(sim_sig_SrcActiv.sigSRC_pre)
        size(sim_sig_SrcActiv.sigSRC_pst)
    end
end

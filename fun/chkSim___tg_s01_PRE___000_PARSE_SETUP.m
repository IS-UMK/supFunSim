
function chkSim___tg_s01_PRE___000_PARSE_SETUP(SETUP,sel_atl)
% Simulations setup parser

    disp('Checking consistency of ''SETUP'' definitions')

    % check if number of ROIs is smaller than number of cortex parcels
    tmp_MaxROIs = size(sel_atl.Atlas(sel_atl.atl).Scouts,2);
    tmp_ActROIs = size(SETUP.SRCS,1);
    if 0
        disp(SETUP.SRCS)
        tmp_MaxROIs
        tmp_ActROIs
    end
    if tmp_ActROIs > tmp_MaxROIs,
        tmp_msg = ['please avoid putting more than ', num2str(tmp_MaxROIs) ' source ROIs (decrease the number of rows in the ''SETUP.SRCS''.)'];
        error(tmp_msg);
    end

    % check if no roi contains more sources than allowed (allowed number
    % of sources is the number of nodes in the ROI that contains the
    % least nodes)
    tmp_MaxSrc = []; for ii = 1:tmp_MaxROIs, tmp_MaxSrc = [tmp_MaxSrc; size(sel_atl.Atlas(sel_atl.atl).Scouts(ii).Vertices,2)]; end;
    tmp_MaxSrc = min(tmp_MaxSrc);
    [tmp_ActSrcs, tmp_ActColMaxIdx] = max(sum(SETUP.SRCS,2));
    if 0
        SETUP.SRCS
        tmp_MaxSrc
        tmp_ActSrcs
        tmp_ActColMaxIdx
    end
    if tmp_ActSrcs > min(tmp_MaxSrc),
        tmp_msg = ['please avoid putting more than ', num2str(tmp_MaxSrc) ' sources in any of the ROIs (decrease sum of the column number ', num2str(tmp_ActColMaxIdx), ' in the ''SETUP.SRCS''.)'];
        error(tmp_msg);
    end

    % Check if a number of ERPs is not greater than the number of signals
    % of interest.
    tmp_MaxERPs = sum(SETUP.SRCS(:,1));
    tmp_ActERPs = SETUP.ERPs;
    if 0
        SETUP.SRCS
        tmp_MaxERPs
        tmp_ActERPs
    end
    if tmp_ActERPs > tmp_MaxERPs,
        tmp_msg = ['please avoid putting more than ', num2str(tmp_MaxERPs) ' ERPs (this is a number of sources of activity of interest, please change the sum in the 1st column of ''SETUP.SRCS'' or the ''SETUP.ERPs'' value.)'];
        error(tmp_msg);
    end

end

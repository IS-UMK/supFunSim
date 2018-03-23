
function [] = ccrender(varargin)

%%
% CCRENDER --- figure rendering settings, usage:
%
% ccrender( axisLimits, finish, origin, originLimits )
%
%  - axisLimits [optional]:
%      limits display to specified range defined using either:
%        - vector of length 2 (all axes have same limits)
%          [ xyzLim_1, xyzLim_2 ],
%        - vector of length 6 (each axis has its own limits)
%          [ xLim_1, xLim_2, yLim_1, yLim_2, zLim_1, zLim_2 ];
%  - finish [optional]:
%      changes rendering scheme;
%  - origin [optional]:
%      true/false;
%  - originLim [optional]:
%      a number.
%
% Questions and comments: nikadon@gmail.com
%
% TODO:
% - add "try" envelopes for major blocks
%
%

%%

p = inputParser;

defAxisLimits = [];
%   chkAxisLimits = @(x) validateattributes(x,{'numeric'},{'vector','numel',2});
chkAxisLimits = @(x) isnumeric(x) && isvector(x) && ( length(x) == 2 || length(x) == 6 );
addOptional(p,'axisLimits',defAxisLimits,chkAxisLimits)

defOriginLimits = [];
chkOriginLimits = @(x) isnumeric(x) && isvector(x) && ( length(x) == 2 || length(x) == 6 );
addOptional(p,'originLimits',defOriginLimits,chkOriginLimits)

defEqualize = false;
chkEqualize = @(x) validateattributes(x,{'logical'},{});
addParameter(p,'equalize',defEqualize,chkEqualize)

defOrigin = true;
chkOrigin = @(x) validateattributes(x,{'logical'},{});
addParameter(p,'origin',defOrigin,chkOrigin)

defLabels = true;
chkLabels = @(x) validateattributes(x,{'logical'},{});
addParameter(p,'labels',defLabels,chkLabels)

defFinish = 'matte';
vldFinish = {'glossy','matte'};
chkFinish = @(x) any(validatestring(x,vldFinish));
addParameter(p,'finish',defFinish,chkFinish)




s = dbstack;


p.KeepUnmatched = true;


parse(p,varargin{:})

tmp_gcf = gcf

ccdisp('INIT: ccrender')
ccdisp(['Updating figure: ',num2str(tmp_gcf.Number),'...'])




if ~isempty(p.UsingDefaults)
    ccdisp([ s(1).name,': Using defaults:'])
    disp(p.UsingDefaults')
end
if ~isempty(p.Results)
    ccdisp([ s(1).name,': Results:'])
    disp(p.Results')
end
if ~isempty(fieldnames(p.Unmatched))
    ccdisp([ s(1).name,': Extra (unmatched) inputs:'])
    disp(p.Unmatched')
end





%%

if length(p.Results.axisLimits) == 2
    if p.Results.axisLimits(1) >= p.Results.axisLimits(2)
        help ccrender;
        error('CYBERCRAFT: axis limits [xyzLim_1,xyzLim_2] must be increasing.');
    else
        axis([ p.Results.axisLimits(1) p.Results.axisLimits(2) p.Results.axisLimits(1) p.Results.axisLimits(2) p.Results.axisLimits(1) p.Results.axisLimits(2) ]);
    end
elseif length(p.Results.axisLimits) == 6
    if p.Results.axisLimits(1) >= p.Results.axisLimits(2)  ||  p.Results.axisLimits(3) >= p.Results.axisLimits(4)  ||  p.Results.axisLimits(5) >= p.Results.axisLimits(6)
        help ccrender;
        error('CYBERCRAFT: axis limits [xLim_1,xLim_2,yLim_1,yLim_2,zLim_1,zLim_2] must be increasing for each axis.');
    else
        axis([ p.Results.axisLimits(1) p.Results.axisLimits(2) p.Results.axisLimits(3) p.Results.axisLimits(4) p.Results.axisLimits(5) p.Results.axisLimits(6) ]);
    end
end
%{
xlim([-15,15])
ylim([-15,15])
zlim([-15,15])
axis square
axis equal
axis auto
%}

if p.Results.equalize == true
    xMin = min(xlim);
    xMax = max(xlim);
    yMin = min(ylim);
    yMax = max(ylim);
    zMin = min(zlim);
    zMax = max(zlim);
    xyzMin = min( [ xMin yMin zMin ] );
    xyzMax = max( [ xMax yMax zMax ] );
    axis([ xyzMin xyzMax xyzMin xyzMax xyzMin xyzMax ]);
end


if p.Results.labels == true
    xlabel('X-axis')
    ylabel('Y-axis')
    zlabel('Z-axis')
end

set(gca,'DataAspectRatio',   [1 1 1])
set(gca,'PlotBoxAspectRatio',[1 1 1])

camproj('perspective'); % perspective | ortographic

%{
set(gca,'Projection','ortographic') % problem here?
                                    %}

set(gca,'CameraViewAngle',10)

az = 60;
el = 30;
view(az, el);

if strcmp(p.Results.finish,'glossy')
    lighting gouraud;
    material shiny;
    camlight;
    %{
    shading interp;
    light;
    lighting phong;
    %}
end

axis on;
box on;

%%
if p.Results.origin
    if length(p.Results.originLimits) == 2
        if p.Results.originLimits(1) > 0
            help ccrender;
            error('CYBERCRAFT: origin axis low limit must be negative number.')
        elseif p.Results.originLimits(2) < 0
            help ccrender;
            error('CYBERCRAFT: origin axis higher limit must be positive number.')
        else
            xMin = p.Results.originLimits(1);
            xMax = p.Results.originLimits(2);
            yMin = p.Results.originLimits(1);
            yMax = p.Results.originLimits(2);
            zMin = p.Results.originLimits(1);
            zMax = p.Results.originLimits(2);
        end
    elseif length(p.Results.originLimits) == 6
        if p.Results.originLimits(1) > 0  ||  p.Results.originLimits(3) > 0  || p.Results.originLimits(5) > 0
            help ccrender;
            error('CYBERCRAFT: origin axis low limit must be negative number.')
        elseif p.Results.originLimits(2) < 0  ||  p.Results.originLimits(4) < 0  ||  p.Results.originLimits(6) < 0
            help ccrender;
            error('CYBERCRAFT: origin axis higher limit must be positive number.')
        else
            xMin = p.Results.originLimits(1);
            xMax = p.Results.originLimits(2);
            yMin = p.Results.originLimits(3);
            yMax = p.Results.originLimits(4);
            zMin = p.Results.originLimits(5);
            zMax = p.Results.originLimits(6);
        end
    else
        xMin = min(xlim);
        xMax = max(xlim);
        yMin = min(ylim);
        yMax = max(ylim);
        zMin = min(zlim);
        zMax = max(zlim);
    end


    hold on




    try
        ccfgFigH = evalin( 'base', 'ccfgFigH' );
    catch
        ccfgFigH = [];
    end



    try
        tmp_fields = fieldnames(ccfgFigH(tmp_gcf.Number).origin);
        for ii = 1:length(tmp_fields)
            try
                delete(ccfgFigH(tmp_gcf.Number).origin.(tmp_fields{ii}));
            catch tmp_catched_2
                fprintf('\n\nPSEUDO-WARNING[2]: %s\n\n',tmp_catched_2.message);
            end
        end
    catch tmp_catched_1
        fprintf('\n\nPSEUDO-WARNING [1]: %s\n\n',tmp_catched_1.message);
    end


    ccfgFigH(tmp_gcf.Number).origin.xp = quiver3( 0, 0, 0, 1.1*xMax, 0,    0,    'color', [1 0 0], 'LineWidth', 1.0, 'LineStyle', '-' ); hold on;
    ccfgFigH(tmp_gcf.Number).origin.yp = quiver3( 0, 0, 0, 0,    1.1*yMax, 0,    'color', [0 1 0], 'LineWidth', 1.0, 'LineStyle', '-' ); hold on;
    ccfgFigH(tmp_gcf.Number).origin.zp = quiver3( 0, 0, 0, 0,    0,    1.1*zMax, 'color', [0 0 1], 'LineWidth', 1.0, 'LineStyle', '-' ); hold on;

    ccfgFigH(tmp_gcf.Number).origin.xn = quiver3( 0, 0, 0, xMin, 0,    0,    'color', [1 0 0], 'LineWidth', 1.0, 'LineStyle', '-.', 'ShowArrowHead', 'off' ); hold on;
    ccfgFigH(tmp_gcf.Number).origin.yn = quiver3( 0, 0, 0, 0,    yMin, 0,    'color', [0 1 0], 'LineWidth', 1.0, 'LineStyle', '-.', 'ShowArrowHead', 'off' ); hold on;
    ccfgFigH(tmp_gcf.Number).origin.zn = quiver3( 0, 0, 0, 0,    0,    zMin, 'color', [0 0 1], 'LineWidth', 1.0, 'LineStyle', '-.', 'ShowArrowHead', 'off' ); hold on;

    ccfgFigH(tmp_gcf.Number).origin.xt = text(   1.2*xMax, 0,        0,        'OX', 'color', [1 0 0] );
    ccfgFigH(tmp_gcf.Number).origin.yt = text(   0,        1.2*yMax, 0,        'OY', 'color', [0 1 0] );
    ccfgFigH(tmp_gcf.Number).origin.zt = text(   0,        0,        1.2*zMax, 'OZ', 'color', [0 0 1] );

    assignin( 'base', 'ccfgFigH', ccfgFigH );

end


%%


xLimits = xlim;
yLimits = ylim;
zLimits = zlim;




ccdisp( [ 'xLimits: [', num2str(xLimits(1)), ', ', num2str(xLimits(2)), ']' ] )
ccdisp( [ 'yLimits: [', num2str(yLimits(1)), ', ', num2str(yLimits(2)), ']' ] )
ccdisp( [ 'zLimits: [', num2str(zLimits(1)), ', ', num2str(zLimits(2)), ']' ] )

grid on;
rotate3d on;
hold on;



ccdisp(['Figure: ',num2str(tmp_gcf.Number),' has been updated!'])


ccdisp('DONE: ccrender')

return

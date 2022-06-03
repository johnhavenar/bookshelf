function [surfax,ax] = createSurfPlotTiled(alpha,M,dataset,location,tilenum,span)

%% Main surface plot.
surfax = nexttile(tilenum,span);
surfax.View = [30 20];
surfax.FontName = 'Times';
surfax.GridLineStyle = '-';
surfax.LineWidth = 0.4;

hold on

sectionList = [0, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00];


% For initializing variables only.
[x,~,~] = importDisp(alpha,M,dataset,location,sectionList(1));

% Create meshgrid.
[X,Y] = meshgrid(x,sectionList);
Z = zeros(length(sectionList),length(x));

% Build displacement matrix.
for iter = 1:length(sectionList)
[~,~,z] = importDisp(alpha,M,dataset,location,sectionList(iter));
Z(iter,:) = z;
end

% Create surface plot.
s = surf(X,Y,Z,'FaceAlpha','1.0','MeshStyle','both',LineWidth=0.2);
colormap turbo

datarange = max(Z,[],'all') - min(Z,[],'all');

caxis([0,0.8*max(Z,[],'all')])
shading faceted
lighting gouraud

%% Axis formatting.

% Parameters.
fontsize = 4;
linewidth = 0.2;
ticklength_2d = 0.01; ticklength_3d = 0.01;
gridline_alpha = 0.8; minorgridline_alpha = 0.2;

% Grab current axes.
ax = gca;
% Format main axes properties.
ax.Units = 'normalized';
ax.LineWidth = linewidth;
ax.FontSize = fontsize;
ax.PlotBoxAspectRatio = [3,2,2];
%ax.Color = '#fcfcfc';

%% Format x-axis.
% Axis properties.
ax.XLim = [0,0.2];
ax.XLabel.String = "t (s)";
ax.XAxis.FontSize = fontsize;
% Major ticks.
ax.XAxis.TickValues = 0:0.04:0.2;
ax.XAxis.TickLabelFormat = '%1.2f';
ax.XAxis.TickLabelRotation = 0;
ax.XAxis.TickDirection = 'both';
ax.XAxis.TickLength = [ticklength_2d,ticklength_3d];
% Minor ticks.
ax.XAxis.MinorTick = 'on';
ax.XAxis.MinorTickValues = 0:0.01:0.2;
ax.XAxis.MinorTickValuesMode = 'auto';

%% Format y-axis.
% Axis properties.
ax.YLim = [0.0,1.0];
ax.YLabel.String = "y/b";
ax.YAxis.FontSize = fontsize;
% Major ticks.
ax.YAxis.TickValues = 0:0.25:1;
ax.YAxis.TickLabelFormat = '%1.2f';
ax.YAxis.TickLabelRotation = 0;
ax.YAxis.TickDirection = 'both';
ax.YAxis.TickLength = [ticklength_2d,ticklength_3d];
% Minor ticks.
ax.YAxis.MinorTick = 'on';
ax.YAxis.MinorTickValues = 0:0.05:1;
ax.YAxis.MinorTickValuesMode = 'auto';

%% Format z-axis.
% Axis properties.
ax.ZLim = [0,0.08];
ax.ZLabel.String = "\delta_z (m)";
ax.ZAxis.FontSize = fontsize;
% Major ticks.
ax.ZAxis.TickValues = 0:0.02:0.08;
ax.ZAxis.TickLabelFormat = '%1.2f';
ax.ZAxis.TickLabelRotation = 0;
ax.ZAxis.TickDirection = 'both';
ax.ZAxis.TickLength = [ticklength_2d,ticklength_3d];
% Minor ticks.
ax.ZAxis.MinorTick = 'on';
ax.ZAxis.MinorTickValues = 0:0.005:0.08;
ax.ZAxis.MinorTickValuesMode = 'auto';

%% Grid lines.
% Major grid.
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.ZGrid = 'on';
ax.GridLineStyle = '-';
ax.GridAlpha = gridline_alpha;
% Minor grid.
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';
ax.ZMinorGrid = 'on';
ax.MinorGridLineStyle = '-';
ax.MinorGridColor = 'k';
ax.MinorGridAlpha = minorgridline_alpha;
% Box.
%ax.Box = 'on';
%ax.BoxStyle = 'back';

%% Text annotation.
txtstring = "\alpha = "+num2str(alpha,'%1.0f')+"°, M = "+num2str(M,'%1.2f');
txtposition = [0.01, 0.01, 0.09]; txtmargin = 0.8;
txtborder = 0.25; txtfontsize = 6;

txtbkg = text;
txtbkg.Parent = ax;
txtbkg.String = txtstring;
txtbkg.Position = txtposition;
txtbkg.FontName = 'Times';
txtbkg.FontSize = txtfontsize;
txtbkg.BackgroundColor = 'k';
txtbkg.Margin = txtborder+txtmargin;
txtbkg.Units = 'normalized';

txt = text;
txt.Parent = ax;
txt.String = txtstring;
txt.Position = txtposition;
txt.FontName = 'Times';
txt.FontSize = txtfontsize;
txt.BackgroundColor = 'w';
txt.Margin = txtmargin;
txt.Units = 'normalized';










hold off
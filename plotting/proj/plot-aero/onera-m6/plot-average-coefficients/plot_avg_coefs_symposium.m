% Create composite graph of time-averaged aerodynamic coefficients vs. Mach number.

clear
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\import-data")
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients")
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients\symposium-graphs")

% blue = [0.0000, 0.4470, 0.7410]; blue_light = [0.6094, 0.8125, 0.9961];
% green = [0.1660, 0.6740, 0.1880]; green_light = [0.7422, 0.9961, 0.7422];
% red = [0.6350, 0.0780, 0.1840]; red_light = [1.0000, 0.6000, 0.6000];
blue = '#1a53ff'; blue_light = [0.6094, 0.8125, 0.9961];
green = '#00b300'; green_light = [0.7422, 0.9961, 0.7422];
red = '#a3142f'; red_light = [1.0000, 0.6000, 0.6000];
labelfontsize = 10; axisfontsize = 10; markersize = 3; linewidth = 0.8;
gridalpha = 0.2;



%% Create tiled graph.
AverageAeroCoefs = tiledlayout(1,2,TileSpacing="loose",Padding="loose");

%% Graph lift coefficient.
AverageLiftGraph = nexttile(1);
AverageLiftGraph.XAxis.FontWeight = 'normal';
AverageLiftGraph.YAxis.FontWeight = 'normal';

hold on

% AEROELASTIC
% Average lift coefficient for AoA = 2° line.
[y,x] = avgLiftCoefMulti(2,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_2deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=blue, Marker='o', ...
    MarkerSize=markersize, MarkerEdgeColor=blue, MarkerFaceColor=blue_light);
% Average lift coefficient for AoA = 4° line.
[y,x] = avgLiftCoefMulti(4,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_4deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=green, Marker='^', ...
    MarkerSize=markersize, MarkerEdgeColor=green, MarkerFaceColor=green_light);
% Average lift coefficient for AoA = 6° line.
[y,x] = avgLiftCoefMulti(6,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_6deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=red, Marker='d', ...
    MarkerSize=markersize, MarkerEdgeColor=red, MarkerFaceColor=red_light);

hold off



%% Graph drag coefficient.
AverageDragGraph = nexttile(2);
AverageDragGraph.XAxis.FontWeight = 'normal';
AverageDragGraph.YAxis.FontWeight = 'normal';

hold on

% AEROELASTIC
% Average drag coefficient for AoA = 2° line.
[y,x] = avgDragCoefMulti(2,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCd_2deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=blue, Marker='o', ...
    MarkerSize=markersize, MarkerEdgeColor=blue, MarkerFaceColor=blue_light);
% Average drag coefficient for AoA = 4° line.
[y,x] = avgDragCoefMulti(4,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCd_4deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=green, Marker='^', ...
    MarkerSize=markersize, MarkerEdgeColor=green, MarkerFaceColor=green_light);
% Average drag coefficient for AoA = 6° line.
[y,x] = avgDragCoefMulti(6,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCd_6deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=red, Marker='d', ...
    MarkerSize=markersize, MarkerEdgeColor=red, MarkerFaceColor=red_light);

hold off

%% Axis formatting.

% Axis formatting for average lift coefficient graph.
axis(AverageLiftGraph,'square');
AverageLiftGraph.FontName = 'Times';
AverageLiftGraph.FontSize = axisfontsize;
AverageLiftGraph.XAxis.TickLabelFormat = '%.1f';
AverageLiftGraph.XAxis.TickValues = 0:0.2:2;
%AverageLiftGraph.XLabel.String = "$  M_{\infty}  $";
AverageLiftGraph.XLabel.String = "$ \mathbf{M_{\infty}}  $";
AverageLiftGraph.XLabel.Interpreter = 'latex';
AverageLiftGraph.XLabel.FontSize = labelfontsize;
AverageLiftGraph.XLim = [0.65,2.05];
AverageLiftGraph.YAxis.TickLabelFormat = '%.1f';
AverageLiftGraph.YAxis.TickValues = 0:0.1:1;
AverageLiftGraph.YLabel.String = "$  \mathbf{\overline{C_{L}}}  $";
AverageLiftGraph.YLabel.Interpreter = 'latex';
AverageLiftGraph.YLabel.FontSize = labelfontsize;
AverageLiftGraph.YLim = [0,0.6];
% Grid lines.
AverageLiftGraph.GridColor = 'k';
AverageLiftGraph.GridAlpha = gridalpha;
AverageLiftGraph.XGrid = 'on';
AverageLiftGraph.YGrid = 'on';
% Box.
AverageLiftGraph.Box = 'on';
AverageLiftGraph.PlotBoxAspectRatio = [3,4,1];


% Axis formatting for average drag coefficient graph.
axis(AverageDragGraph,'square');
AverageDragGraph.FontName = 'Times';
AverageDragGraph.FontSize = axisfontsize;
AverageDragGraph.XAxis.TickLabelFormat = '%.1f';
AverageDragGraph.XAxis.TickValues = 0:0.2:2;
AverageDragGraph.XLabel.String = "$  \mathbf{M_{\infty}}  $";
AverageDragGraph.XLabel.Interpreter = 'latex';
AverageDragGraph.XLabel.FontSize = labelfontsize;
AverageDragGraph.XLim = [0.65,2.05];
AverageDragGraph.YAxis.TickLabelFormat = '%.2f';
AverageDragGraph.YAxis.TickValues = 0:0.03:1;
AverageDragGraph.YLabel.String = "$  \mathbf{\overline{C_{D}}}  $";
AverageDragGraph.YLabel.Interpreter = 'latex';
AverageDragGraph.YLabel.FontSize = labelfontsize;
AverageDragGraph.YLim = [0,0.15];
% Grid lines.
AverageDragGraph.GridColor = 'k';
AverageDragGraph.GridAlpha = gridalpha;
AverageDragGraph.XGrid = 'on';
AverageDragGraph.YGrid = 'on';
% Box.
AverageDragGraph.Box = 'on';
AverageDragGraph.PlotBoxAspectRatio = [3,4,1];


%% Legend formatting.
lgd = legend(["$$  \alpha = 2^{\circ}  $$" "$$  \alpha = 4^{\circ}  $$" "$$  \alpha = 6^{\circ}  $$"], ...
    Interpreter="latex", FontSize=8, Orientation='vertical', EdgeColor='k',NumColumns=1);
lgd.Layout.Tile = 2;
lgd.Location = 'southeast';



%% Export the composite graph.
exportgraphics(gcf,"C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients\symposium-graphs\AvgCoefs-Graph.png","Resolution",600)

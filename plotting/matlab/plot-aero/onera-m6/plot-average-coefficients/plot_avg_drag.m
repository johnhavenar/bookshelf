% Graph time-averaged drag coefficient vs Mach number.

clear
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\import-data")
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients")
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients\graphs")

blue = [0.0000, 0.4470, 0.7410]; blue_light = [0.6094, 0.8125, 0.9961];
green = [0.1660, 0.6740, 0.1880]; green_light = [0.7422, 0.9961, 0.7422];
red = [0.6350, 0.0780, 0.1840]; red_light = [1.0000, 0.6000, 0.6000];
labelfontsize = 11; markersize = 2; linewidth = 0.8;


%% Graph time-averaged drag coefficients.
AverageDragvsMach = figure;
AverageDragGraph = axes;

hold on

%% Aeroelastic data.
% Average drag coefficient for AoA = 2° line.
[y,x] = avgDragCoefMulti(2,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_2deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=blue, Marker='o', ...
    MarkerSize=markersize, MarkerEdgeColor=blue, MarkerFaceColor=blue_light);
% Average drag coefficient for AoA = 4° line.
[y,x] = avgDragCoefMulti(4,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_4deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=green, Marker='^', ...
    MarkerSize=markersize, MarkerEdgeColor=green, MarkerFaceColor=green_light);
% Average drag coefficient for AoA = 6° line.
[y,x] = avgDragCoefMulti(6,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_6deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=red, Marker='d', ...
    MarkerSize=markersize, MarkerEdgeColor=red, MarkerFaceColor=red_light);

%% Rigid data.
% Average drag coefficient for AoA = 2° line.
[y,x] = avgDragCoefRigidMulti(2,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_2deg = plot(x,y, LineStyle='--', LineWidth=linewidth, Color=blue, Marker='o', ...
    MarkerSize=markersize, MarkerEdgeColor=blue, MarkerFaceColor=blue_light);
% Average drag coefficient for AoA = 4° line.
[y,x] = avgDragCoefRigidMulti(4,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_4deg = plot(x,y, LineStyle='--', LineWidth=linewidth, Color=green, Marker='^', ...
    MarkerSize=markersize, MarkerEdgeColor=green, MarkerFaceColor=green_light);
% Average drag coefficient for AoA = 6° line.
[y,x] = avgDragCoefRigidMulti(6,[0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.10 1.20]);
AvgCl_6deg = plot(x,y, LineStyle='--', LineWidth=linewidth, Color=red, Marker='d', ...
    MarkerSize=markersize, MarkerEdgeColor=red, MarkerFaceColor=red_light);


hold off

%% Axis formatting.
axis(AverageDragGraph,'square');
AverageDragGraph.FontName = 'Times';
AverageDragGraph.XAxis.TickLabelFormat = '%.2f';
AverageDragGraph.XAxis.TickValues = 0:0.2:2;
AverageDragGraph.XLabel.String = "$M_{\infty}$";
AverageDragGraph.XLabel.Interpreter = 'latex';
AverageDragGraph.XLabel.FontSize = labelfontsize;
AverageDragGraph.XLim = [0.65,2.05];
AverageDragGraph.YAxis.TickLabelFormat = '%.2f';
AverageDragGraph.YAxis.TickValues = 0:0.02:1;
AverageDragGraph.YLabel.String = "$\overline{C_{D}}$";
AverageDragGraph.YLabel.Interpreter = 'latex';
AverageDragGraph.YLabel.FontSize = labelfontsize;
AverageDragGraph.YLim = [0,0.16];

%% Legend formatting.
lgd = legend(["$$\alpha=2^{\circ}\ \textup{(FSI)}$$" "$$\alpha=4^{\circ}\ \textup{(FSI)}$$" "$$\alpha=6^{\circ}\ \textup{(FSI)}$$" ...
    "$$\alpha=2^{\circ}\ \textup{(Rigid)}$$" "$$\alpha=4^{\circ}\ \textup{(Rigid)}$$" "$$\alpha=6^{\circ}\ \textup{(Rigid)}$$"], ...
    Interpreter="latex", Location="southoutside", FontSize=8, Orientation='vertical', EdgeColor='none',NumColumns=2);
%% Export graphics.
exportgraphics(gcf,"C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients\graphs\AvgDragCoefs-Graph.png","Resolution",600)
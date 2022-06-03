% Graph time-averaged lift coefficient vs Mach number.
%%
clear
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\import-data")
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients")
addpath("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients\graphs")

blue = '#0072be'; blue_light = '#9cd0ff';
green = '#2aac30'; green_light = '#beffbe';
red = '#a3142f'; red_light = '#ff9a9a';
labelfontsize = 11; markersize = 2; linewidth = 0.6;


%% Graph time-averaged lift coefficients.
AverageLiftvsMach = figure;
AverageLiftGraph = axes;

hold on

%% Aeroelastic data.
% Average lift coefficient for AoA = 2° line.
[y,x] = avgLiftCoefMulti(2,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_2deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=blue, Marker='o', ...
    MarkerSize=markersize, MarkerEdgeColor=blue, MarkerFaceColor=blue_light);
% Average lift coefficient for AoA = 4° line.
[y,x] = avgLiftCoefMulti(4,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_4deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=green, Marker='>', ...
    MarkerSize=markersize, MarkerEdgeColor=green, MarkerFaceColor=green_light);
% Average lift coefficient for AoA = 6° line.
[y,x] = avgLiftCoefMulti(6,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_6deg = plot(x,y, LineStyle='-', LineWidth=linewidth, Color=red, Marker='d', ...
    MarkerSize=markersize, MarkerEdgeColor=red, MarkerFaceColor=red_light);

%% Rigid data.
% Average lift coefficient for AoA = 2° line.
[y,x] = avgLiftCoefRigidMulti(2,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_2deg = plot(x,y, LineStyle='--', LineWidth=linewidth, Color=blue, Marker='o', ...
    MarkerSize=markersize, MarkerEdgeColor=blue, MarkerFaceColor=blue_light);
% Average lift coefficient for AoA = 4° line.
[y,x] = avgLiftCoefRigidMulti(4,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_4deg = plot(x,y, LineStyle='--', LineWidth=linewidth, Color=green, Marker='>', ...
    MarkerSize=markersize, MarkerEdgeColor=green, MarkerFaceColor=green_light);
% Average lift coefficient for AoA = 6° line.
[y,x] = avgLiftCoefRigidMulti(6,[0.70 0.75 0.80 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.10 1.20 1.40 1.60 1.80 2.00]);
AvgCl_6deg = plot(x,y, LineStyle='--', LineWidth=linewidth, Color=red, Marker='d', ...
   MarkerSize=markersize, MarkerEdgeColor=red, MarkerFaceColor=red_light);

hold off



%% Axis formatting.
axis(AverageLiftGraph,'square');
AverageLiftGraph.FontSize = 10;
% X-axis
AverageLiftGraph.FontName = 'Times';
AverageLiftGraph.XAxis.TickLabelFormat = '%.2f';
AverageLiftGraph.XAxis.TickValues = 0:0.05:2;
AverageLiftGraph.XLabel.String = "$M_{\infty}$";
AverageLiftGraph.XLabel.Interpreter = 'latex';
AverageLiftGraph.XLabel.FontSize = labelfontsize;
AverageLiftGraph.XLim = [0.80,1.05];
% Y-axis
AverageLiftGraph.YAxis.TickLabelFormat = '%.2f';
AverageLiftGraph.YAxis.TickValues = 0:0.05:1;
AverageLiftGraph.YLabel.String = "$\overline{C_{L}}$";
AverageLiftGraph.YLabel.Interpreter = 'latex';
AverageLiftGraph.YLabel.FontSize = labelfontsize;
AverageLiftGraph.YLim = [0.05,0.65];
% Grid lines
AverageLiftGraph.GridLineStyle = '-';
AverageLiftGraph.XGrid = 'on';
AverageLiftGraph.YGrid = 'on';
AverageLiftGraph.GridColor = 'k';
AverageLiftGraph.GridAlpha = 0.1;



%% Legend formatting.
lgd = legend(["$$\alpha=2^{\circ}\ \textup{(FSI)}$$" "$$\alpha=4^{\circ}\ \textup{(FSI)}$$" "$$\alpha=6^{\circ}\ \textup{(FSI)}$$" ...
    "$$\alpha=2^{\circ}\ \textup{(Rigid)}$$" "$$\alpha=4^{\circ}\ \textup{(Rigid)}$$" "$$\alpha=6^{\circ}\ \textup{(Rigid)}$$"], ...
    Interpreter="latex", Location="southoutside", FontSize=8, Orientation='vertical', EdgeColor='none',NumColumns=2);


%% Export graphics.
exportgraphics(gcf,"C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\plot-average-coefficients\graphs\AvgLiftCoefs-Graph.png","Resolution",600,BackgroundColor='white')
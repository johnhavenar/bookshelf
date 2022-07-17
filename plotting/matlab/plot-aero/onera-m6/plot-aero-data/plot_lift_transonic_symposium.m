clear;
clc;

%% Set data parameters.

alpha = 6;

%% Set formatting parameters.
axisfontsize = 20;
plotlinewidth = 1.4;

%% Create figure.
figure;
DataGraph = axes;

%% Import and plot data.
hold on
[x,y] = importAero(alpha,0.80,'lift','fsi');
plot(x,y,Color='#406aa4',LineWidth=plotlinewidth)
[x,y] = importAero(alpha,0.90,'lift','fsi');
plot(x,y,Color='#50a7d3',LineWidth=plotlinewidth)
[x,y] = importAero(alpha,1.00,'lift','fsi');
plot(x,y,Color='#80c34a',LineWidth=plotlinewidth)
[x,y] = importAero(alpha,1.20,'lift','fsi');
plot(x,y,Color='#f3af16',LineWidth=plotlinewidth)
[x,y] = importAero(alpha,1.40,'lift','fsi');
plot(x,y,Color='#ec2f28',LineWidth=plotlinewidth)
[x,y] = importAero(alpha,1.60,'lift','fsi');
plot(x,y,Color='#e62e90',LineWidth=plotlinewidth)

%% Graph text.
% Text.
xlabeltext = "$$ t \ \textnormal{[s]} $$";
ylabeltext = "$$ \overline{C_{L}} $$";
legendlabels = ["M=0.80", "M=0.90", "M=1.00", "M=1.20", "M=1.40", "M=1.60"];
%% Format axes.
% Text formatting.
DataGraph.FontName = 'Times';
DataGraph.FontSize = axisfontsize;

% Axis formatting.
%DataGraph.XLim = [0,0.1];
%DataGraph.YLim = [0.25,0.65];
DataGraph.XTick = 0:0.02:1;
DataGraph.YTick = 0:0.1:1;
xlabel(xlabeltext,Interpreter="latex",FontSize=axisfontsize);
ylabel(ylabeltext,Interpreter="latex",FontSize=axisfontsize);

%% Format lines.
DataGraph.LineWidth = 1.2;

%% Format graph area.
DataGraph.Box = 'on';
DataGraph.PlotBoxAspectRatio = [6,3,1];
DataGraph.XGrid = 'on';
DataGraph.YGrid = 'on';
DataGraph.GridColor = 'k';
DataGraph.GridAlpha = 0.2;

%% Format legend.
legend(legendlabels,Interpreter="latex",Location="southoutside",Orientation="vertical",NumColumns=3)

exportgraphics(gca,['symposium-graphs/lift-coef-transonic-compare-',num2str(alpha,'%1.0f'),'deg.png'],Resolution=600)

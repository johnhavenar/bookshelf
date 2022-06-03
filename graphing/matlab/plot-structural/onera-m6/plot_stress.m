clear;
clc;

%% Set data parameters.
for iter = [2 4 6]

alpha = iter;

%% Set formatting parameters.
axisfontsize = 20;
plotlinewidth = 1;

%% Create figure.
figure;
DataGraph = axes;
DataGraph.XGrid = 'on';
DataGraph.YGrid = 'on';
DataGraph.GridColor = 'k';
DataGraph.GridAlpha = 0.2;

%% Import and plot data.
hold on
[x,y] = importStruct(alpha,0.80,'equStress');
plot(x,y,Color='#406aa4',LineWidth=plotlinewidth)
[x,y] = importStruct(alpha,0.90,'equStress');
plot(x,y,Color='#50a7d3',LineWidth=plotlinewidth)
[x,y] = importStruct(alpha,1.00,'equStress');
plot(x,y,Color='#80c34a',LineWidth=plotlinewidth)
[x,y] = importStruct(alpha,1.20,'equStress');
plot(x,y,Color='#f3af16',LineWidth=plotlinewidth)
[x,y] = importStruct(alpha,1.40,'equStress');
plot(x,y,Color='#ec2f28',LineWidth=plotlinewidth)
[x,y] = importStruct(alpha,1.60,'equStress');
plot(x,y,Color='#e62e90',LineWidth=plotlinewidth)

%% Format graph.
DataGraph.FontName = 'Times';
DataGraph.FontSize = axisfontsize;
DataGraph.Box = 'on';
DataGraph.LineWidth = 1.2;


%% Format axes.
DataGraph.XLim = [0,0.1];
DataGraph.YLim = [-15,130];
DataGraph.YTick = [0:30:120];

DataGraph.PlotBoxAspectRatio = [6,3,1];

if alpha == 6
    xlabel("$$ t \ \textnormal{[s]} $$",Interpreter="latex",FontSize=axisfontsize);
else
    set(gca,'Xticklabel',[])
end
ylabel("$$ \sigma_{equ} \ \textnormal{[MPa]} $$",Interpreter="latex",FontSize=axisfontsize);

% legend(["M=0.80", "M=0.90", "M=1.00", "M=1.20", "M=1.40", "M=1.60"],Interpreter="latex",Location="southoutside",Orientation="vertical",NumColumns=3)

exportgraphics(gca,['graphs/equ-stress-',num2str(alpha,'%1.0f'),'deg.png'],Resolution=600)

end
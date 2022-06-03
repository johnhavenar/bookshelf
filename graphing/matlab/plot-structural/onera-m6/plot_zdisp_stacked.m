clear;
clc;

%% Set data parameters.
Angles = [2, 4, 6];
MachNumbers = [0.80, 0.90, 1.00, 1.20, 1.40, 1.60];

iter = 1;
alpha = 2;




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

hold off
for iter = 1:length(MachNumbers)
%% Import and plot data.
Time = importStruct(alpha,MachNumbers(iter),'time');
DataArray = [importStruct(2,MachNumbers(iter),'zDispOnly'), ...
            importStruct(4,MachNumbers(iter),'zDispOnly') ...
            importStruct(6,MachNumbers(iter),'zDispOnly')];

%% Plot data.
DataGraph = stackedplot(Time,DataArray);

end

% %% Format graph.
% DataGraph.FontName = 'Times';
% DataGraph.FontSize = axisfontsize;
% DataGraph.Box = 'on';
% 
% 
% %% Format axes.
% DataGraph.XLim = [0,0.1];
% DataGraph.YLim = [-2,28];
% DataGraph.YTick = [0:4:28];
% 
% DataGraph.PlotBoxAspectRatio = [5,3,1];
% 
% if alpha == 6
% xlabel("$$ t \ \textnormal{[s]} $$",Interpreter="latex",FontSize=axisfontsize);
% end
% ylabel("$$ \delta_{z} \ \textnormal{[mm]} $$",Interpreter="latex",FontSize=axisfontsize);
% 
% % legend(["M=0.80", "M=0.90", "M=1.00", "M=1.20", "M=1.40", "M=1.60"],Interpreter="latex",Location="southoutside",Orientation="vertical",NumColumns=3)
% 
% exportgraphics(gca,['graphs/z-disp-',num2str(alpha,'%1.0f'),'deg.png'],Resolution=600)

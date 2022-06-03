function ax = graph_data(test,section,format)
%GRAPH_DATA  Creates a graph of CFD and experimental pressure coefficients.
%  INPUTS:
%    test: float = ID number of comparison case
%    section: float = Span station number of data sets
%    format: struct = A structure containing formatting keys
%  OUTPUTS:
%    ax: Axes = Axes object with data and formatting

Angles = ["2.06" "2.05" "6.07"];
MachNumbers = ["0.7001" "0.9180" "0.9298"];
SectionLocations = ["0.20" "0.44" "0.65" "0.80" "0.90" "0.96" "0.99"];

% Return flow parameter variables.
alpha = Angles(test);
M = MachNumbers(test);
eta = SectionLocations(section);

%% Process formatting inputs.
if isfield(format,'lgdfontsize')
    lgdfontsize = format.lgdfontsize;
else
    lgdfontsize = 9;
end
if isfield(format,'axfontsize')
    axfontsize = format.axfontsize;
else
    axfontsize = 10;
end
if isfield(format,'txtfontsize')
    txtfontsize = format.txtfontsize;
else
    txtfontsize = 10;
end
if isfield(format,'markersize')
    markersize = format.markersize;
else
    markersize = 10;
end

%% Create and format axes.
% Create axes.
if isfield(format,'plottype')
switch format.plottype
    case 'tiled'
        ax = nexttile;
    case 'plot'
        ax = axes;
    otherwise
        disp("Invalid plot type");
end
end

% Format axes.
ax.XAxis.Label.String = "$$ {x/c} $$";
ax.XAxis.Label.Interpreter = 'latex';
ax.YAxis.Label.String = "$$ {C_{p}} $$";
ax.YAxis.Label.Interpreter = 'latex';
ax.YDir = 'reverse';
ax.FontName = 'Times';
ax.FontSize = axfontsize;
ax.XLim = [-0.05,1.05];
ax.PlotBoxAspectRatio = [4,3,1];
ax.XTick = 0:0.2:1;
ax.YTick = -1.6:0.4:1.2;
ax.YTickLabel = {'-1.6', '-1.2', '-0.8', '-0.4', '0.0', '0.4', '0.8', '1.2'};
xtickformat(ax,'%.1f');
ax.Box = 'on';
ax.XGrid = 'on';
ax.YGrid = 'on';


%% Plot and format CFD data points.
% Import and plot CFD data points.
FluentDataPoints = gobjects(1,2);
[x,cp] = import_data(test,section,'lower');
FluentDataPoints(1) = line(x,cp);
[x,cp] = import_data(test,section,'upper');
FluentDataPoints(2) = line(x,cp);

% Format CFD data points.
FluentDataPoints(1).Marker = 'none'; FluentDataPoints(1).Color = 'b';  FluentDataPoints(1).LineStyle = '-';
FluentDataPoints(2).Marker = 'none'; FluentDataPoints(2).Color = 'r'; FluentDataPoints(2).LineStyle = '-';
for iter = 1:2
    FluentDataPoints(iter).LineWidth = 1.0;
    FluentDataPoints(iter).MarkerFaceColor = 'none'; FluentDataPoints(iter).MarkerEdgeColor = 'k';
end

%% Plot and format experimental data points.
ExpDataPoints = gobjects(1,2);
[x,cp] = import_exp_data(test,section,'lower');
ExpDataPoints(1) = line(x,cp);
[x,cp] = import_exp_data(test,section,'upper');
ExpDataPoints(2) = line(x,cp);

% Format experimental data points.
ExpDataPoints(1).Marker = 'd'; ExpDataPoints(1).MarkerSize = markersize;
ExpDataPoints(2).Marker = 's'; ExpDataPoints(2).MarkerSize = markersize*1.3;
for iter = 1:2
    ExpDataPoints(iter).Color = 'none'; ExpDataPoints(iter).LineWidth = 0.5;
    ExpDataPoints(iter).MarkerFaceColor = 'w'; ExpDataPoints(iter).MarkerEdgeColor = 'k';
end

%% Annotate graph.
if isfield(format,'text')
    switch format.text
        case 'y'
            textString = ["$$ M_{\infty}="+M+" $$"+"$$ ,\  $$"+"$$ \alpha="+alpha+"^{\circ} $$","$$ \ \eta="+eta+" $$"];
            txt = text(0.15,0.15,0,textString,"Units","normalized",Interpreter="latex",FontSize=txtfontsize,EdgeColor='none');
    end
end

%% Create and format legend.
if isfield(format,'legend')
    switch format.legend
        case 'y'
            lgd = legend;
            lgd.Box;
            lgd.String = ["$$ \textnormal{k-$\omega$ SST, Lower Surface} $$" "$$ \textnormal{k-$\omega$ SST, Upper Surface} $$" "$$ \textnormal{ONERA, Lower Surface} $$" "$$ \textnormal{ONERA, Upper Surface} $$"];
            lgd.Interpreter = 'latex';
            lgd.Location = 'southeast';
            lgd.FontSize = lgdfontsize;
        otherwise
    end
end

end

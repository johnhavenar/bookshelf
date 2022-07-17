%VALIDATION_GRAPHS_TILED Creates a tiled plot of validation graphs.
% Requirements: graph_data.m, import_data.m, import_exp_data.m

%% Set formatting options.

clear;
clc;

format.plottype = 'tiled';
format.legend = 'n';
format.text = 'y';
format.axfontsize = 9;
format.lgdfontsize = 10;
format.txtfontsize = 9;
format.markersize = 3;

t = tiledlayout(2,2,"TileSpacing","compact","TileIndexing","rowmajor");


%% Graph data.
graph_data(1,2,format);
graph_data(1,4,format);
graph_data(2,2,format);
graph_data(2,4,format);




%% Export tiled plot.
%exportgraphics(t,"validation-graphs.pdf",Resolution=600,ContentType="vector");
exportgraphics(t,"validation-graphs.png",Resolution=600);

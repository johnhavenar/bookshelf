function [exp_x,exp_cp] = import_cp_exp(section)

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["exp_x", "exp_cp"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
tbl = readtable("E:\Aeroelasticity Research\asdmad-1\data\datasets\experimental\cp_"+section+"_experimental.csv", opts);

%% Convert to output type
exp_x = tbl.exp_x;
exp_cp = tbl.exp_cp;

%% Clear temporary variables
clear opts tbl


end
function [x,cp] = import_cp(section)


%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [5, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["x", "cp"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
tbl = readtable("E:\Aeroelasticity Research\asdmad-1\data\datasets\fluent\pres-coef-"+section+".xy", opts);

%% Convert to output type
x = tbl.x;
cp = tbl.cp;

%% Clear temporary variables
clear opts tbl


%% Rescale to unit length.
x = (x-min(x));
x = x ./ max(x);

end
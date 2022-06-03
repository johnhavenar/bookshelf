function [x,cp,alpha,M,eta] = import_data(test,section,side)

Angles = ["2.06" "2.05" "6.07"];
MachNumbers = ["0.7001" "0.9180" "0.9298"];
SectionLocations = ["0.20" "0.44" "0.65" "0.80" "0.90" "0.96" "0.99"];

% Return flow parameter variables.
alpha = Angles(test);
M = MachNumbers(test);
eta = SectionLocations(section);
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
tbl = readtable("data\Case-"+test+"-"+alpha+"-"+M+"\cp-"+side+"-surface-"+section+".xy", opts);

%% Convert to output type
x = tbl.x;
cp = tbl.cp;

x = x - min(x);
x = x/max(x);

%% Clear temporary variables
clear opts tbl

end
function [x,cp,alpha,M,eta] = import_exp_data(test,section,side)

Angles = ["2.06" "2.05" "6.07"];
MachNumbers = ["0.7001" "0.9180" "0.9298"];
SectionLocations = ["0.20" "0.44" "0.65" "0.80" "0.90" "0.96" "0.99"];

% Return flow parameter variables.
alpha = Angles(test);
M = MachNumbers(test);
eta = SectionLocations(section);

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 20);
% Specify sheet and range
opts.Sheet = "2585";
opts.DataRange = "A2:T46";
% Specify column names and types
opts.VariableNames = ["x1", "cp1", "Var3", "x2", "cp2", "Var6", "x3", "cp3", "Var9", "x4", "cp4", "Var12", "x5", "cp5", "Var15", "x6", "cp6", "Var18", "x7", "cp7"];
opts.SelectedVariableNames = ["x1", "cp1", "x2", "cp2", "x3", "cp3", "x4", "cp4", "x5", "cp5", "x6", "cp6", "x7", "cp7"];
opts.VariableTypes = ["double", "double", "char", "double", "double", "char", "double", "double", "char", "double", "double", "char", "double", "double", "char", "double", "double", "char", "double", "double"];
% Specify variable properties
opts = setvaropts(opts, ["Var3", "Var6", "Var9", "Var12", "Var15", "Var18"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var3", "Var6", "Var9", "Var12", "Var15", "Var18"], "EmptyFieldRule", "auto");
% Import the data
addpath("data\Case-"+test+"-"+alpha+"-"+M);
tbl = readtable("data\Case-"+test+"-"+alpha+"-"+M+"\exp_data.xlsx", opts, "UseExcel", false);
%% Convert to output type
switch section
    case 1
        x = tbl.x1; cp = tbl.cp1;
    case 2
        x = tbl.x2; cp = tbl.cp2;
    case 3
        x = tbl.x3; cp = tbl.cp3;
    case 4
        x = tbl.x4; cp = tbl.cp4;
    case 5
        x = tbl.x5; cp = tbl.cp5;
    case 6
        x = tbl.x6; cp = tbl.cp6;
    case 7
        x = tbl.x7; cp = tbl.cp7;
end  
%% Clear temporary variables
clear opts tbl

if (section >= 1) && (section < 4)
    lower_start = 1;
    lower_end = 11;
    upper_start = 12;
    upper_end = 34;
else
    lower_start = 1;
    lower_end = 14;
    upper_start = 15;
    upper_end = 45;
end

switch side
    case 'lower'
        x = x(lower_start:lower_end);
        cp = cp(lower_start:lower_end);
    case 'upper'
        x = x(upper_start:upper_end);
        cp = cp(upper_start:upper_end);
    otherwise
        disp('Invalid side.');
end

end
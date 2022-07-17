function [x,y,alpha,M] = importStruct(alpha,M,dataset)

%% Format inputs.
alpha = num2str(alpha,'%1.0f');
M = num2str(M,'%1.2f');

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 7);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["step", "xDisp", "yDisp", "zDisp", "equStress", "time", "Var7"];
opts.SelectedVariableNames = ["step", "xDisp", "yDisp", "zDisp", "equStress", "time"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "Var7", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var7", "EmptyFieldRule", "auto");

% Import the data
filename = ["C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\reports\reports-fsi\structural-data\report-structural-data-"+alpha+"-"+M+".out"];
tbl = readtable(filename, opts);

%% Convert to output type
step = tbl.step;
xDisp = tbl.xDisp;
yDisp = tbl.yDisp;
zDisp = tbl.zDisp;
equStress = tbl.equStress;
time = tbl.time;

%% Clear temporary variables
clear opts tbl

%% Select output data.
x = time;
switch dataset
    case 'xDisp'
        y = xDisp.*1000;
    case 'yDisp'
        y = yDisp.*1000;
    case 'zDisp'
        y = zDisp.*1000;
    case 'equStress'
        y = equStress./1000000;
    case 'xDispOnly'
        x = xDisp.*1000;
    case 'yDispOnly'
        x = yDisp.*1000;
    case 'zDispOnly'
        x = zDisp.*1000;
    case 'equStressOnly'
        x = equStress./1000000;
    case 'time'
        x = time;
    otherwise
        disp('No flow data selected.');
end

end
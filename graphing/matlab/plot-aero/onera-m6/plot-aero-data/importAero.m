function [x,y,alpha,M] = importAero(alpha,M,dataset,analysis)

%% Format inputs.
alpha = num2str(alpha,'%1.0f');
M = num2str(M,'%1.2f');

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 17);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["step", "liftCoef", "dragCoef", "presCoef020", "presCoef040", "presCoef060", "presCoef080", "presCoef090", "presCoef095", "fricCoef020", "fricCoef040", "fricCoef060", "fricCoef080", "fricCoef090", "fricCoef095", "time", "Var17"];
opts.SelectedVariableNames = ["step", "liftCoef", "dragCoef", "presCoef020", "presCoef040", "presCoef060", "presCoef080", "presCoef090", "presCoef095", "fricCoef020", "fricCoef040", "fricCoef060", "fricCoef080", "fricCoef090", "fricCoef095", "time"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "Var17", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var17", "EmptyFieldRule", "auto");

%% Import the data.
switch analysis
    case 'fsi'
        filename = "C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\reports\reports-fsi\aero-coefs\report-aero-coefs-"+alpha+"-"+M+".out";
    case 'rigid'
        filename = "C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6\reports\reports-rigid\aero-coefs\report-aero-coefs-"+alpha+"-"+M+".out";
    otherwise
        disp("Analysis type no valid.")
end
tbl = readtable(filename, opts);

%% Convert to output type
step = tbl.step;
liftCoef = tbl.liftCoef;
dragCoef = tbl.dragCoef;
time = tbl.time;

%% Clear temporary variables
clear opts tbl

%% Select output data.
x = time;
switch dataset
    case 'lift'
        y = liftCoef;
    case 'drag'
        y = dragCoef;
    case 'time'
        x = time;
    otherwise
        disp('No flow data selected.');
end

end
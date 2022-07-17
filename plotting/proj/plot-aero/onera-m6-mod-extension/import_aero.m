function [x,y,alpha,M] = import_aero(alpha,M,dataset,datatype)
% import_disp Import aerodynamic data by angle of attack, Mach number, 
% data type, and aerodynamic coefficient name.
%
% Arguments:
% alpha: float
% M: float
% dataset: char = 'lift' | 'drag' | 'pitching moment' | 'bending moment'
%                 'pitching coef' | 'bending coef'
% datatype: char = 'transient' | 'avg' | 'max' | 'min'
% 
% Returns:
% time: double vector
% aerodynamic data: double vector
% alpha: char
% M: char


%% Calculate freestream conditions if needed.
mach = M;
V = 343*mach;
rho = 1.176655;
T = 300;
q = rho*V^2/2;
S = 1;
c = 1;

%% Format inputs.
alpha = num2str(alpha,'%1.0f');
M = num2str(M,'%1.2f');

%% Import data from text file

% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 7);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["step", "coef_lift" "coef_drag" "moment_pitching" "moment_bending" "time" "null"];
opts.SelectedVariableNames = ["step", "coef_lift" "coef_drag" "moment_pitching" "moment_bending" "time"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "null", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "null", "EmptyFieldRule", "auto");

% Import the data
tbl = readtable("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6-modified\mod-extension\reports\fsi\aero-coefs\report-aero-coefs-"+alpha+"-"+M+".out", opts);

%% Convert to output type
step = tbl.step;
cl = tbl.coef_lift;
cd = tbl.coef_drag;
mp = tbl.moment_pitching;
mb = tbl.moment_bending;
time = tbl.time;

%% Clear temporary variables
clear opts tbl

%% Select output data.
x = time;
switch dataset
    case 'lift'
        y = cl;
    case 'drag'
        y = cd;
    case 'pitching moment'
        y = mp;
    case 'bending moment'
        y = mb;
    case 'pitching coef'
        y = mp ./ (q*S*c);
    case 'bending coef'
        y = mb ./ (q*S*c);
end

%% Process data if needed.
switch datatype
    case 'avg'
        y = mean(y);
    case 'max'
        y = max(y);
    case 'min'
        y = min(y);
end

end
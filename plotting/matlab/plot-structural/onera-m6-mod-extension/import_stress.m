function [x,y,alpha,M] = import_stress(alpha,M,dataset)
% import_disp Import displacement data by angle of attack, Mach number,
% displacement type, location on wing, and normalized length along span.
%
% Arguments:
% alpha: float
% M: float
% dataset: char
% 
% Returns:
% time: double vector
% eta: double vector
% displacement: double vector
% alpha: char
% M: char


%% Format inputs.
alpha = num2str(alpha,'%1.0f');
M = num2str(M,'%1.2f');

%% Import data from text file

% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 10);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["step", "wing_equ_stress" "wing_sigma_xx" "wing_sigma_xy" "wing_sigma_xz" "wing_sigma_yy" "wing_sigma_yz" "wing_sigma_zz", "time", "null"];
opts.SelectedVariableNames = ["step", "wing_equ_stress" "wing_sigma_xx" "wing_sigma_xy" "wing_sigma_xz" "wing_sigma_yy" "wing_sigma_yz" "wing_sigma_zz", "time"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double","string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "null", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "null", "EmptyFieldRule", "auto");

% Import the data
tbl = readtable("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6-modified\mod-extension\reports\fsi\stress-data\report-stress-data-"+alpha+"-"+M+".out", opts);

%% Convert to output type
step = tbl.step;
equ_stress = tbl.wing_equ_stress;
sigma_xx = tbl.wing_sigma_xx;
sigma_xy = tbl.wing_sigma_xy;
sigma_xz = tbl.wing_sigma_xz;
sigma_yy = tbl.wing_sigma_yy;
sigma_yz = tbl.wing_sigma_yz;
sigma_zz = tbl.wing_sigma_zz;

time = tbl.time;

%% Clear temporary variables
clear opts tbl

%% Select output data.
x = time;
switch dataset
    case 'equ'
        y = equ_stress;
    case 'xx'
        y = sigma_xx;
    case 'xy'
        y = sigma_xy;
    case 'xz'
        y = sigma_xz;
    case 'yy'
        y = sigma_yy;
    case 'yz'
        y = sigma_yz;
    case 'zz'
        y = sigma_zz;        
end

end
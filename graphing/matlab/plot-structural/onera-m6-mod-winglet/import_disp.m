function [x,y,z,alpha,M] = import_disp(alpha,M,dataset,location,section)
% import_disp Import displacement data by angle of attack, Mach number,
% displacement type, location on wing, and normalized length along span.
%
% Arguments:
% alpha: float
% M: float
% dataset: char = 'xDisp' | 'yDisp' | 'zDisp'
% location: char = 'le' | 'te' | 'wingtip'
% section: float
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
section = num2str(section,'%1.2f');

%% Import data from text file

% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 66);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["step", "sp_le_010_xDisp", "sp_le_010_yDisp", "sp_le_010_zDisp", "sp_le_020_xDisp", "sp_le_020_yDisp", "sp_le_020_zDisp", "sp_le_030_xDisp", "sp_le_030_yDisp", "sp_le_030_zDisp", "sp_le_040_xDisp", "sp_le_040_yDisp", "sp_le_040_zDisp", "sp_le_050_xDisp", "sp_le_050_yDisp", "sp_le_050_zDisp", "sp_le_060_xDisp", "sp_le_060_yDisp", "sp_le_060_zDisp", "sp_le_070_xDisp", "sp_le_070_yDisp", "sp_le_070_zDisp", "sp_le_080_xDisp", "sp_le_080_yDisp", "sp_le_080_zDisp", "sp_le_090_xDisp", "sp_le_090_yDisp", "sp_le_090_zDisp", "sp_le_100_xDisp", "sp_le_100_yDisp", "sp_le_100_zDisp", "sp_te_010_xDisp", "sp_te_010_yDisp", "sp_te_010_zDisp", "sp_te_020_xDisp", "sp_te_020_yDisp", "sp_te_020_zDisp", "sp_te_030_xDisp", "sp_te_030_yDisp", "sp_te_030_zDisp", "sp_te_040_xDisp", "sp_te_040_yDisp", "sp_te_040_zDisp", "sp_te_050_xDisp", "sp_te_050_yDisp", "sp_te_050_zDisp", "sp_te_060_xDisp", "sp_te_060_yDisp", "sp_te_060_zDisp", "sp_te_070_xDisp", "sp_te_070_yDisp", "sp_te_070_zDisp", "sp_te_080_xDisp", "sp_te_080_yDisp", "sp_te_080_zDisp", "sp_te_090_xDisp", "sp_te_090_yDisp", "sp_te_090_zDisp", "sp_te_100_xDisp", "sp_te_100_yDisp", "sp_te_100_zDisp", "sp_wingtip_xDisp", "sp_wingtip_yDisp", "sp_wingtip_zDisp", "time", "null"];
opts.SelectedVariableNames = ["step", "sp_le_010_xDisp", "sp_le_010_yDisp", "sp_le_010_zDisp", "sp_le_020_xDisp", "sp_le_020_yDisp", "sp_le_020_zDisp", "sp_le_030_xDisp", "sp_le_030_yDisp", "sp_le_030_zDisp", "sp_le_040_xDisp", "sp_le_040_yDisp", "sp_le_040_zDisp", "sp_le_050_xDisp", "sp_le_050_yDisp", "sp_le_050_zDisp", "sp_le_060_xDisp", "sp_le_060_yDisp", "sp_le_060_zDisp", "sp_le_070_xDisp", "sp_le_070_yDisp", "sp_le_070_zDisp", "sp_le_080_xDisp", "sp_le_080_yDisp", "sp_le_080_zDisp", "sp_le_090_xDisp", "sp_le_090_yDisp", "sp_le_090_zDisp", "sp_le_100_xDisp", "sp_le_100_yDisp", "sp_le_100_zDisp", "sp_te_010_xDisp", "sp_te_010_yDisp", "sp_te_010_zDisp", "sp_te_020_xDisp", "sp_te_020_yDisp", "sp_te_020_zDisp", "sp_te_030_xDisp", "sp_te_030_yDisp", "sp_te_030_zDisp", "sp_te_040_xDisp", "sp_te_040_yDisp", "sp_te_040_zDisp", "sp_te_050_xDisp", "sp_te_050_yDisp", "sp_te_050_zDisp", "sp_te_060_xDisp", "sp_te_060_yDisp", "sp_te_060_zDisp", "sp_te_070_xDisp", "sp_te_070_yDisp", "sp_te_070_zDisp", "sp_te_080_xDisp", "sp_te_080_yDisp", "sp_te_080_zDisp", "sp_te_090_xDisp", "sp_te_090_yDisp", "sp_te_090_zDisp", "sp_te_100_xDisp", "sp_te_100_yDisp", "sp_te_100_zDisp", "sp_wingtip_xDisp", "sp_wingtip_yDisp", "sp_wingtip_zDisp", "time"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "null", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "null", "EmptyFieldRule", "auto");

% Import the data
tbl = readtable("C:\Users\jackh\OneDrive\MATLAB\aeroelasticity_research\onera-m6-modified\mod-winglet\reports\fsi\displacement-data\report-displacement-data-"+alpha+"-"+M+".out", opts);

%% Convert to output type
step = tbl.step;

sp_le_010_xDisp = tbl.sp_le_010_xDisp;
sp_le_010_yDisp = tbl.sp_le_010_yDisp;
sp_le_010_zDisp = tbl.sp_le_010_zDisp;
sp_le_020_xDisp = tbl.sp_le_020_xDisp;
sp_le_020_yDisp = tbl.sp_le_020_yDisp;
sp_le_020_zDisp = tbl.sp_le_020_zDisp;
sp_le_030_xDisp = tbl.sp_le_030_xDisp;
sp_le_030_yDisp = tbl.sp_le_030_yDisp;
sp_le_030_zDisp = tbl.sp_le_030_zDisp;
sp_le_040_xDisp = tbl.sp_le_040_xDisp;
sp_le_040_yDisp = tbl.sp_le_040_yDisp;
sp_le_040_zDisp = tbl.sp_le_040_zDisp;
sp_le_050_xDisp = tbl.sp_le_050_xDisp;
sp_le_050_yDisp = tbl.sp_le_050_yDisp;
sp_le_050_zDisp = tbl.sp_le_050_zDisp;
sp_le_060_xDisp = tbl.sp_le_060_xDisp;
sp_le_060_yDisp = tbl.sp_le_060_yDisp;
sp_le_060_zDisp = tbl.sp_le_060_zDisp;
sp_le_070_xDisp = tbl.sp_le_070_xDisp;
sp_le_070_yDisp = tbl.sp_le_070_yDisp;
sp_le_070_zDisp = tbl.sp_le_070_zDisp;
sp_le_080_xDisp = tbl.sp_le_080_xDisp;
sp_le_080_yDisp = tbl.sp_le_080_yDisp;
sp_le_080_zDisp = tbl.sp_le_080_zDisp;
sp_le_090_xDisp = tbl.sp_le_090_xDisp;
sp_le_090_yDisp = tbl.sp_le_090_yDisp;
sp_le_090_zDisp = tbl.sp_le_090_zDisp;
sp_le_100_xDisp = tbl.sp_le_100_xDisp;
sp_le_100_yDisp = tbl.sp_le_100_yDisp;
sp_le_100_zDisp = tbl.sp_le_100_zDisp;

sp_te_010_xDisp = tbl.sp_te_010_xDisp;
sp_te_010_yDisp = tbl.sp_te_010_yDisp;
sp_te_010_zDisp = tbl.sp_te_010_zDisp;
sp_te_020_xDisp = tbl.sp_te_020_xDisp;
sp_te_020_yDisp = tbl.sp_te_020_yDisp;
sp_te_020_zDisp = tbl.sp_te_020_zDisp;
sp_te_030_xDisp = tbl.sp_te_030_xDisp;
sp_te_030_yDisp = tbl.sp_te_030_yDisp;
sp_te_030_zDisp = tbl.sp_te_030_zDisp;
sp_te_040_xDisp = tbl.sp_te_040_xDisp;
sp_te_040_yDisp = tbl.sp_te_040_yDisp;
sp_te_040_zDisp = tbl.sp_te_040_zDisp;
sp_te_050_xDisp = tbl.sp_te_050_xDisp;
sp_te_050_yDisp = tbl.sp_te_050_yDisp;
sp_te_050_zDisp = tbl.sp_te_050_zDisp;
sp_te_060_xDisp = tbl.sp_te_060_xDisp;
sp_te_060_yDisp = tbl.sp_te_060_yDisp;
sp_te_060_zDisp = tbl.sp_te_060_zDisp;
sp_te_070_xDisp = tbl.sp_te_070_xDisp;
sp_te_070_yDisp = tbl.sp_te_070_yDisp;
sp_te_070_zDisp = tbl.sp_te_070_zDisp;
sp_te_080_xDisp = tbl.sp_te_080_xDisp;
sp_te_080_yDisp = tbl.sp_te_080_yDisp;
sp_te_080_zDisp = tbl.sp_te_080_zDisp;
sp_te_090_xDisp = tbl.sp_te_090_xDisp;
sp_te_090_yDisp = tbl.sp_te_090_yDisp;
sp_te_090_zDisp = tbl.sp_te_090_zDisp;
sp_te_100_xDisp = tbl.sp_te_100_xDisp;
sp_te_100_yDisp = tbl.sp_te_100_yDisp;
sp_te_100_zDisp = tbl.sp_te_100_zDisp;

sp_wingtip_xDisp = tbl.sp_wingtip_xDisp;
sp_wingtip_yDisp = tbl.sp_wingtip_yDisp;
sp_wingtip_zDisp = tbl.sp_wingtip_zDisp;

time = tbl.time;

%% Clear temporary variables
clear opts tbl

%% Select output data.
x = time;
switch dataset
    case 'xDisp'
        switch location
            case 'le'
                switch section
                    case '0.10'
                        z = sp_le_010_xDisp;
                    case '0.20'
                        z = sp_le_020_xDisp;
                    case '0.30'
                        z = sp_le_030_xDisp;
                    case '0.40'
                        z = sp_le_040_xDisp;
                    case '0.50'
                        z = sp_le_050_xDisp;
                    case '0.60'
                        z = sp_le_060_xDisp;
                    case '0.70'
                        z = sp_le_070_xDisp;
                    case '0.80'
                        z = sp_le_080_xDisp;
                    case '0.90'
                        z = sp_le_090_xDisp;
                    case '1.00'
                        z = sp_le_100_xDisp;
                end
            case 'te'
                switch section
                    case '0.10'
                        z = sp_te_010_xDisp;
                    case '0.20'
                        z = sp_te_020_xDisp;
                    case '0.30'
                        z = sp_te_030_xDisp;
                    case '0.40'
                        z = sp_te_040_xDisp;
                    case '0.50'
                        z = sp_te_050_xDisp;
                    case '0.60'
                        z = sp_te_060_xDisp;
                    case '0.70'
                        z = sp_te_070_xDisp;
                    case '0.80'
                        z = sp_te_080_xDisp;
                    case '0.90'
                        z = sp_te_090_xDisp;
                    case '1.00'
                        z = sp_te_100_xDisp;
                end
            case 'wingtip'
                z = sp_wingtip_xDisp;
        end
    case 'yDisp'
        switch location
            case 'le'
                switch section
                    case '0.10'
                        z = sp_le_010_yDisp;
                    case '0.20'
                        z = sp_le_020_yDisp;
                    case '0.30'
                        z = sp_le_030_yDisp;
                    case '0.40'
                        z = sp_le_040_yDisp;
                    case '0.50'
                        z = sp_le_050_yDisp;
                    case '0.60'
                        z = sp_le_060_yDisp;
                    case '0.70'
                        z = sp_le_070_yDisp;
                    case '0.80'
                        z = sp_le_080_yDisp;
                    case '0.90'
                        z = sp_le_090_yDisp;
                    case '1.00'
                        z = sp_le_100_yDisp;
                end
            case 'te'
                switch section
                    case '0.10'
                        z = sp_te_010_yDisp;
                    case '0.20'
                        z = sp_te_020_yDisp;
                    case '0.30'
                        z = sp_te_030_yDisp;
                    case '0.40'
                        z = sp_te_040_yDisp;
                    case '0.50'
                        z = sp_te_050_yDisp;
                    case '0.60'
                        z = sp_te_060_yDisp;
                    case '0.70'
                        z = sp_te_070_yDisp;
                    case '0.80'
                        z = sp_te_080_yDisp;
                    case '0.90'
                        z = sp_te_090_yDisp;
                    case '1.00'
                        z = sp_te_100_yDisp;
                end
            case 'wingtip'
                z = sp_wingtip_yDisp;
        end
    case 'zDisp'
        switch location
            case 'le'
                switch section
                    case '0.10'
                        z = sp_le_010_zDisp;
                    case '0.20'
                        z = sp_le_020_zDisp;
                    case '0.30'
                        z = sp_le_030_zDisp;
                    case '0.40'
                        z = sp_le_040_zDisp;
                    case '0.50'
                        z = sp_le_050_zDisp;
                    case '0.60'
                        z = sp_le_060_zDisp;
                    case '0.70'
                        z = sp_le_070_zDisp;
                    case '0.80'
                        z = sp_le_080_zDisp;
                    case '0.90'
                        z = sp_le_090_zDisp;
                    case '1.00'
                        z = sp_le_100_zDisp;
                end
            case 'te'
                switch section
                    case '0.10'
                        z = sp_te_010_zDisp;
                    case '0.20'
                        z = sp_te_020_zDisp;
                    case '0.30'
                        z = sp_te_030_zDisp;
                    case '0.40'
                        z = sp_te_040_zDisp;
                    case '0.50'
                        z = sp_te_050_zDisp;
                    case '0.60'
                        z = sp_te_060_zDisp;
                    case '0.70'
                        z = sp_te_070_zDisp;
                    case '0.80'
                        z = sp_te_080_zDisp;
                    case '0.90'
                        z = sp_te_090_zDisp;
                    case '1.00'
                        z = sp_te_100_zDisp;
                end
            case 'wingtip'
                z = sp_wingtip_zDisp;
        end
end

if section == '0.00'
    z = zeros(size(x));
end

y = zeros(size(x));
y = y + str2double(section);





end
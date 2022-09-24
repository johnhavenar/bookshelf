function fname = locate_report(flow_param,opts)
%LOCATE_REPORT Locates report file when given analysis parameters.
arguments
    flow_param {mustBeNumeric}
    opts.data_set {mustBeTextScalar} = "aero-coefs"
    opts.analysis_type {mustBeTextScalar} = "fsi"
    opts.report_dir = "../reports"
end

data_set=opts.data_set;
analysis_type=opts.analysis_type;
report_dir=opts.report_dir;

% Locate report files in the report directory.
report_info = struct2table(dir(fullfile(report_dir,'**','*.out')));

% Get report paths.
report_paths = string(fullfile(report_info.folder,report_info.name));

% Determine type of analysis.
report_type = string(regexp(report_paths,'(?<=\\)((fsi)|(rigid))(?=\\)','match'));

% Determine data set.
report_data_set = regexp(report_info.name,'(?<=-)([^0-9]*)(?=-)','match');
report_data_set = string(vertcat(report_data_set{:,1}));

% Parse flow parameters.
report_flow_params = regexp(string(report_info.name),'(?<=-)([0-9\.]*)(?=[-\.])','match');
report_flow_params = str2double(vertcat(report_flow_params{:}));
% Build labels for flow parameters.
param_var_names = strcat("param",string((1:size(report_flow_params,2))'))';
% Split the flow parameter multicolumn variable into individual variables.
rfile = splitvars(table(report_data_set,report_type,report_flow_params,report_paths));

% Build and label the main report file table.
rfile.Properties.VariableNames = ["dataset","type",param_var_names,"fname"];
rfile.dataset = categorical(rfile.dataset);
rfile.type = categorical(rfile.type);
idx = ones(size(rfile,1),1);
for i=1:length(param_var_names)
    idx = idx & (rfile{:,param_var_names(i)} == flow_param(i));
end

% Locate report file in main table.
rfile_i = rfile.dataset==data_set & rfile.type==analysis_type & idx;
fname = rfile{rfile_i,"fname"};
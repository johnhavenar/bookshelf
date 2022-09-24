function data = read_data(fname)
%READ_DATA Reads and stores time history data from Fluent report files.
arguments
    fname {mustBeFile}
end

fid = fopen(fname);
assert(fid>=3,"File could not be opened.")

report_title = fgetl(fid);
report_desc = fgetl(fid);
vars = fgetl(fid);

vars = regexp(vars,'(?<=")[\w].*?(?=")','match')'; % Extract quoted strings.
vars = lower(vars); % Convert all variable name text to lowercase.
vars = regexprep(vars,'[-\s]','_'); % Remove invalid separator characters.
vars = regexprep(vars,'\.',''); % Remove decimals.

num_vars = length(vars);

fspec = repmat('%f',1,num_vars);

var_data = textscan(fid,fspec);
data = cell2struct(var_data',vars)';

fclose(fid);

end
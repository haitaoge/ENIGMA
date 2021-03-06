function Z = zscore_matrix(data, group, controlCode)
%
% Usage: Z = zscore_matrix(values, group, controlCode)
%
% z-scores data w.r.t. a specific group
%
%   Inputs:
%      data         = data matrix (e.g. thickness data, #subjects x #parcels)
%      group        = vector of values (i.e., grp assignment) same length as #subjects
%      controlCode  = value that corresponds to control subjects
%
%   Outputs:
%       Z           = z-scored data relative to control code (e.g., HCs)
%
%
% Sara Lariviere  |  saratheriver@gmail.com
%
% Last modifications:
% SL | still a hot and humid day in August 2020 (whatta summer we've been having!)

data_orig = data;
if istable(data_orig)
    data = table2array(data);
else
    data = data_orig;
end

if isstring(controlCode)
    C = strcmp(group, controlCode); 
elseif isreal(controlCode)
    C = find(group == controlCode);
end

n = length(group);
Z = (data - repmat(mean(data(C, :), 1), n, 1)) ...
    ./ std(data(C, :));

if istable(data_orig)
    Z  = array2table(Z, 'VariableNames', data_orig.Properties.VariableNames);
end

return
function [y_wo_outliers, idx_wo_outliers, idx_outliers] = ig_remove_outliers(y,n_scaled_MADs)

if nargin < 2,
    n_scaled_MADs = 3;
end

% Outliers are defined as elements more than three scaled MAD from the median. 
% The scaled MAD is defined as c*median(abs(A-median(A))), where c=-1/(sqrt(2)*erfcinv(3/2)).

isOutlier = abs(y) > -n_scaled_MADs/(sqrt(2)*erfcinv(3/2))*median(abs(y - median(y)));
idx_wo_outliers = find(~isOutlier);
idx_outliers = find(isOutlier);
y_wo_outliers = y(idx_wo_outliers);
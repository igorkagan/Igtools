function s = sterr_dbm(x,y)
mfile_name = mfilename; disp_ig_warning(mfile_name);

% standard error of difference between means

s = sqrt(std(x)^2/length(x) + std(y)^2/length(y));

function s = ig_sterr_dbm(x,y)
%IG_STERR_DBM		- standard error of difference between means

s = sqrt(std(x)^2/length(x) + std(y)^2/length(y));
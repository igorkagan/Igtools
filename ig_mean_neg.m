function M = ig_mean_neg(X,dim)
%IG_MEAN_NEG		- mean negative: replace positive entries in vector with NaN

X(X>0) = NaN;
M = nanmean(X,dim);


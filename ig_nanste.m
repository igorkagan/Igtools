function out1 = ig_nanste(in1)
%IG_NANSTE		- nanste (standard error ignoring NaNs)
% see also /external/sterr 

nonnan = find(~isnan(in1));
out1 = nanstd(in1)/sqrt(length(nonnan));


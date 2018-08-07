function out1 = nanste(in1)
mfile_name = mfilename; disp_ig_warning(mfile_name);

nonnan = find(~isnan(in1));

out1 = nanstd(in1)/sqrt(length(nonnan));


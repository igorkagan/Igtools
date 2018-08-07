function y = probit(p)
mfile_name = mfilename; disp_ig_warning(mfile_name);

y = sqrt(2)*erfinv(2*p-1);

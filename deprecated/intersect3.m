function s4 = intersect3(s1,s2,s3)
mfile_name = mfilename; disp_ig_warning(mfile_name);
ss = intersect(s1,s2);
s4 = intersect(ss,s3);


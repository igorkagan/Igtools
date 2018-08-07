function cv = cv2(x1,x2)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% coefficient of variation for 2 values
% uses "biased" normalization by N in the formulation "cv = std/mean"

cv = sqrt( ((x1-mean([x1 x2]))^2 + (x2-mean([x1 x2]))^2)/2) / mean([x1 x2]) ;

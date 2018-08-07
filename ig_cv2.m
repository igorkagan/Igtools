function cv = ig_cv2(x1,x2)
%IG_CV2		- coefficient of variation for 2 values
% uses "biased" normalization by N in the formulation "cv = std/mean"

cv = sqrt( ((x1-mean([x1 x2]))^2 + (x2-mean([x1 x2]))^2)/2) / mean([x1 x2]) ;
function d = ig_cohen_d_norawdata(m1,m2,s1,s2,n1,n2)
%IG_COHEN_D_NORAWDATA		- cohen d norawdata
% works for independent samples
% m - mean, s - SD, n - number of samples

% SD -> VAR
v1 = s1^2;
v2 = s2^2;

d = (m1-m2)/sqrt( ((n1-1)*v1 + (n2-1)*v2)/(n1+n2-2) );
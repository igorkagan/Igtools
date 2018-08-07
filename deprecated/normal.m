function out = normal(s,mini,maxi)
mfile_name = mfilename; disp_ig_warning(mfile_name);

if nargin < 2,
        mini = 0;
end

if nargin < 3,
        maxi = 1;
end

s = s - min(s);
s = s/max(s);

s = s*(maxi-mini) + mini;



out = s;

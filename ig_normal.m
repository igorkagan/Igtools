function out = ig_normal(s,mini,maxi)
%IG_NORMAL		- normalize vector s between mini and maxi

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
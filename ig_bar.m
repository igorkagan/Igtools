function [xx,yy] = ig_bar(X,Y,WIDTH)
%IG_BAR		- bar plot

if nargin < 3,
    WIDTH = 1;
end

v = version;
if strcmp(v(1),'5') | strcmp(v(1),'6')
	[xx,yy] = bar(X,Y,WIDTH);

else
	h_bar = bar(X,Y,WIDTH);
	xx = get(h_bar,'Xdata');
	yy = get(h_bar,'Ydata');
end



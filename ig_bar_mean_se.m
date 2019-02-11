function ig_bar_mean_se(x,y,stat,varargin) 
%IG_BAR_MEAN_SE		- plots mean and sterr/std of a vector as a bar with error bars

if nargin < 3
	stat = 'sterr';
end

if strcmp(stat,'sterr'),
	e = sterr(y);
else
	e = std(y,1);
end

m = mean(y);
bar(x,m,varargin{:}); hold on
h = errorbar(x,m,e,'Marker','none','Color',[0 0 0]);
% hold on; plot(x,y,'o');
errorbar_tick(h,0.3,'units');
	

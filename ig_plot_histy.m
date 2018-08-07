function ig_plot_histy(x,y,bins,markers,varargin)
%IG_PLOT_HISTY		- plot histogram on Y axis

if nargin < 3,
	bins = [-2:0.2:2];
end

if nargin < 4,
	markers = num2str(x); % fix this
end
n = length(x);

hist_span = 10;

plot(hist_span+x,y,varargin{:}); hold on;

[h,bins] = hist(y,bins);
plot(hist2per(h)/100*3*hist_span,bins,varargin{:});
set(gca,'Xlim',[0 hist_span+n+1],'XTick',hist_span+[1:n],'XTickLabel',markers,'FontSize',6);
add_zero_lines;
[H,P] = ttest(y,0);

ig_add_title(sprintf(' mean %.2f p %.2f',mean(x),P));
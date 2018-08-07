function ig_add_linear_regression_line(slope,intercept,varargin)
%IG_ADD_LINEAR_REGRESSION_LINE		- add linear regression line

xlim = get(gca,'Xlim');
ylim = get(gca,'ylim');

x1 = xlim(1);
x2 = xlim(2);
y1 = intercept + x1*slope;
y2 = intercept + x2*slope;

line([x1 x2],[y1 y2],varargin{:});
set(gca,'Xlim',xlim,'Ylim',ylim);

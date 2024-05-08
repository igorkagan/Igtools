function ig_add_horizontal_line(y,varargin)
%IG_ADD_HORIZONTAL_LINE		- add horizontal line

xlim = get(gca,'xlim');
line([xlim(1) xlim(2)],[y y],varargin{:});

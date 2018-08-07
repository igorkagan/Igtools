function ig_add_vertical_line(x,varargin)
%IG_ADD_VERTICAL_LINE		- add vertical line

ylim = get(gca,'ylim');
line([x x],[ylim(1) ylim(2)],varargin{:});


function ig_add_multiple_vertical_lines(vertical_lines_x,varargin)
%IG_ADD_MULTIPLE_VERTICAL_LINES		- add multiple vertical lines

ylim = get(gca,'Ylim');

vertical_lines_x  = vertical_lines_x(:)'; % make row

line(kron(vertical_lines_x,[1 1 1]),repmat([ylim NaN],1,length(vertical_lines_x)),varargin{:});

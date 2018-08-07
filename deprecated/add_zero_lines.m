function add_zero_lines(x,y)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% add_zero_lines(1,0); % horizontal
% add_zero_lines(0,1); % vertical
% add_zero_lines(1,1); % both

if nargin < 1,
	x = 1;
	y = 1;
end

xlim = get(gca,'Xlim');
ylim = get(gca,'ylim');

if x,
	line([xlim(1) xlim(2)],[0 0],'Color','k','LineStyle',':');
end
if y,
	line([0 0],[ylim(1) ylim(2)],'Color','k','LineStyle',':');
end

set(gca,'Xlim',xlim,'Ylim',ylim);

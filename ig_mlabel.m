function ig_mlabel(x1,y1,z1,varargin)
%IG_MLABEL		- add mlabel (xlabel, ylabel, title)

if nargin < 2,
	y1='';
end
if nargin < 3,
	z1='';
end

ha = axes;
pos = get(ha,'Position');
% set(ha,'Position',[pos(1) - pos(1)/10 pos(2) - pos(2)/10 pos(3) + pos(3)/10 pos(4) + pos(4)/10]);

hx = xlabel(x1,varargin{:});
hy = ylabel(y1,varargin{:});
hz = title(z1,varargin{:});
hz_pos = get(hz,'Position');
set(hz,'Position',[hz_pos(1)-hz_pos(1)/20 hz_pos(2)+hz_pos(2)/25],'HorizontalAlignment','center');

set(ha,'Visible','off');
set([hx,hy,hz],'Visible','on');

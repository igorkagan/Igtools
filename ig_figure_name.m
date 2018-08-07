function h = ig_figure_name(figname,alignment)
%IG_FIGURE_NAME		- add figure name

if nargin < 1,
	figname = get(gcf,'Name');
end

if nargin < 2,
	alignment = 'left';
end

fpos = get(gcf,'Position');
h = uicontrol(gcf,'Style','text','String',figname,'Units','Pixels','Position',[5 fpos(4)-15 fpos(3) 15],'HorizontalAlignment',alignment,'BackgroundColor',[1 1 1]);


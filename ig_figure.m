function h = ig_figure(varargin)
%IG_FIGURE		- open figure with some predetermined settings and figure name

if isnumeric(varargin{1}),
	h = figure(varargin{1});
	set(h,'PaperType','A4','Color',[1 1 1],varargin{2:end}),
else
	h = figure('PaperType','A4','Color',[1 1 1],varargin{1:end});
end

figname = get(gcf,'Name');
ig_figure_name(figname);
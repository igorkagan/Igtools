function saveas_all(format,add_figname,alignment)
mfile_name = mfilename; disp_ig_warning(mfile_name);

if nargin < 1,
	format = 'pdf';
end

if nargin < 2,
	add_figname = 0;
end

if nargin < 3,
	alignment = 'left';
end

hWin = sort(get(0,'Children'));
set(get(0,'Children'),'PaperType','A4','PaperPositionMode', 'auto');

for i=1:length(hWin);
        set(0,'CurrentFigure',hWin(i));
	name = get(hWin(i),'name');
	if add_figname,
		ig_figure_name(name,alignment);
	end
	
	saveas(hWin(i),['fig_' name '.' format],format);
end

function set_all_axes(ax,lim)
mfile_name = mfilename; disp_ig_warning(mfile_name);

axises = get(gcf,'Children');

for k = 1:length(axises)
	if ~strcmp(get(axises(k),'Tag'),'image') &&  ~strcmp(get(axises(k),'Type'),'uicontrol'),
		set(axises(k),ax,lim);
	end
end

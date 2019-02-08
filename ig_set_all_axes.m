function ig_set_all_axes(ax,lim)
%IG_SET_ALL_AXES		- set all axes to specific Xlim/Ylim/Zlim limit
% ax can be 'Xlim', 'Ylim', 'Zlim' property

axises = get(gcf,'Children');

for k = 1:length(axises)
	if ~strcmp(get(axises(k),'Tag'),'image') &&  ~strcmp(get(axises(k),'Type'),'uicontrol') && ~strcmp(get(axises(k),'Type'),'uicontextmenu'),
		set(axises(k),ax,lim);
	end
end
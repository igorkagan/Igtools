function ig_set_caxis_equal_lim_figures(h)
%IG_SET_CAXIS_EQUAL_LIM_FIGURES		- set caxis equal lim in all figures
% call ig_set_caxis_equal_lim before using this function!
% figures should have equal number of axes

if nargin < 1,
    h = get(0,'Children');
end

if length(h)<2,
        return;
end


for f = 1:length(h),
        ax(f,:) = ig_get_figure_axes(h(f));
        lim(f,:) = get(ax(f,1),'Clim');
end
set(ax,'Clim',[min(min(lim)) max(max(lim))]); 
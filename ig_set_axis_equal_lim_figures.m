function ig_set_axis_equal_lim_figures(h)
%IG_SET_AXIS_EQUAL_LIM_FIGURES		- set equal axes lim in all figures
% figures should have equal number of axes

if nargin < 1,
    h = get(0,'Children');
end

if length(h)<2,
        return;
end


for f = 1:length(h),
        ax(f,:) = ig_get_figure_axes(h(f));
        
        for a=1:length(ax(f,:)),
            xlim(f,a,:) = get(ax(f,a),'xlim');
            ylim(f,a,:) = get(ax(f,a),'ylim');
        end
        
end

for a = 1:length(ax(f,:)),
    set(ax(:,a),'xlim',[min(min(squeeze(xlim(:,a,:)))) max(max(squeeze(xlim(:,a,:))))],'ylim',[min(min(squeeze(ylim(:,a,:)))) max(max(squeeze(ylim(:,a,:))))]); 
end
function figure_axes = ig_get_figure_axes(h);
%IG_GET_FIGURE_AXES		- get figure axes

if nargin < 1,
        h = gcf;
end

ax = get(h,'Children');
axes_idx = find(strcmp(get(ax,'Type'),'axes'));

figure_axes = ax(axes_idx);
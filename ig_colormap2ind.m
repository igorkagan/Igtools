function [ind,map] = ig_colormap2ind(rgb)
%IG_COLORMAP2IND		- convert colormap to indices

% im = NaN(1,length(rgb),3);
% im(1,1:length(rgb),:) = rgb;
% 
% [ind,map] = rgb2ind(im,rgb,'nodither'); 


% the funny thing (after few hours of debugging) that one has to remove the
% last "repeating" portion of the colormap, so that index values are mapped
% linearly to first unique values of the colormap
% something like:
% map = map(1:last_unique_color_idx,:);
% ind = ind+1;


% or, better (simpler) alternative: 
% ind should be indices of the full colormap, from 1 to N

ind = 1:size(rgb,1);
map = rgb;


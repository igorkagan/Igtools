function ig_set_caxis_equal_lim(h)
%IG_SET_CAXIS_EQUAL_LIM		- set CAXIS equal (min max of all)
%--------------------------------------------------------------------------------
% Input(s): 	h - set of handlers
%               MODE - 'Xlim' or 'Ylim'
% Output(s):	none
% Usage:	set_axes_equal_lim(h,'Ylim')

%
% Last modified 11.12.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

if nargin < 1,
    h = ig_get_figure_axes;
end

if length(h)<2,
        return;
end

Lim = get(h,'Clim');

for i=1:size(Lim,1);
        L(i,:) = Lim{i};
end
set(h,'Clim',[min(min(L)) max(max(L))]); 
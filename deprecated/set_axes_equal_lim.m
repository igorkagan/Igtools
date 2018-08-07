function set_axes_equal_lim(h,MODE)
mfile_name = mfilename; disp_ig_warning(mfile_name);

% set_axes_equal_lim	- set axes Xlim or Ylim to equal (min max of all)
%--------------------------------------------------------------------------------
% Input(s): 	h - set of handlers
%               MODE - 'Xlim' or 'Ylim' or 'all'
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
	MODE = 'all';
end

if ischar(h),
	MODE = h;
	h = ig_get_figure_axes;
end

if length(h)<2,
	return;
end

if strcmp(MODE,'all'),
	MODE = 'Xlim';
	Lim = get(h,MODE);
	for i=1:size(Lim,1);
		L(i,:) = Lim{i};
	end
	set(h,MODE,[min(min(L)) max(max(L))]);
	MODE = 'Ylim';
	Lim = get(h,MODE);
	for i=1:size(Lim,1);
		L(i,:) = Lim{i};
	end
	set(h,MODE,[min(min(L)) max(max(L))]);
else
	Lim = get(h,MODE);
	for i=1:size(Lim,1);
		L(i,:) = Lim{i};
	end
	set(h,MODE,[min(min(L)) max(max(L))]);
end


function set_xy_axes_equal
mfile_name = mfilename; disp_ig_warning(mfile_name);

% set_axes_equal_lim	- set axes Xlim and Ylim  equal (min max of all)
%--------------------------------------------------------------------------------
% Input(s): 	none
% Output(s):	none
% Usage:	set_axes_equal_lim;

%
% Last modified 11.12.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

Xlim = get(gca,'Xlim');
Ylim = get(gca,'Ylim');

minlim = min([Xlim(1) Ylim(1)]);
maxlim = max([Xlim(2) Ylim(2)]);


set(gca,'Xlim',[minlim maxlim],'Ylim',[minlim maxlim]); 

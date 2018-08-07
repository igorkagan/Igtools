function h_type = get_type(h,TYPE)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% get_type	- get handlers to a certain object type
%--------------------------------------------------------------------------------
% Input(s): 	h - set of handlers
%               TYPE - object type
% Output(s):	h_type - set of handlers to objects of type TYPE
% Usage:	h_type = get_type(get(gcf,'Children'),'axes');

%
% Last modified 11.12.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

TYPE = lower(TYPE);
types = get(h,'type');
type_idx = find(strcmp(types,TYPE));
h_type = h(type_idx);

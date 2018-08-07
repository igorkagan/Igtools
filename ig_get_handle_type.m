function h_type = ig_get_handle_type(h,TYPE)
%IG_GET_HANDLE_TYPE		- get handles to a certain object type
%--------------------------------------------------------------------------------
% Input(s): 	h - set of handles
%               TYPE - object type
% Output(s):	h_type - set of handles to objects of type TYPE
% Usage:	h_type = ig_get_handle_type(get(gcf,'Children'),'axes');

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
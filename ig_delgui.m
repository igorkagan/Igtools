function ig_delgui
%IG_DELGUI		- delete all GUI objects from figure
%--------------------------------------------------------------------------------
% Input(s): 	none
% Output(s):	none
% Usage:	ig_delgui
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also IG_GRABIMAGE.
%--------------------------------------------------------------------------------

GUIobjects = [findall(gcf,'type','uicontrol')];
delete(GUIobjects)

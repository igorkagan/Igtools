function delgui
mfile_name = mfilename; disp_ig_warning(mfile_name);
% delgui	- delete all GUI objects from figure
%--------------------------------------------------------------------------------
% Input(s): 	none
% Output(s):	none
% Usage:	delgui
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also GRABIMAGE.
%--------------------------------------------------------------------------------

GUIobjects = [findall(gcf,'type','uicontrol')];
delete(GUIobjects)

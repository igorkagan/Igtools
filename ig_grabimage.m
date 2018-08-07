function ig_grabimage
%IG_GRABIMAGE		- delete all objects from gca except for image (gco) (or any gco)
%--------------------------------------------------------------------------------
% Input(s): 	none
% Output(s):	none
% Usage:	ig_grabimage
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also DELGUI.
%--------------------------------------------------------------------------------

hi = gco;
ha = gca;
c = get(gca,'Children');
for i=1:length(c), if c(i)~=hi, delete(c(i)); end; end;

c = get(gcf,'Children');
for i=1:length(c), if c(i)~=ha, delete(c(i)); end; end;

set(gca,'Visible','off')


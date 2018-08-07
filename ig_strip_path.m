function filename=ig_strip_path(fullfilename)
%IG_STRIP_PATH		- remove path from full filename
%--------------------------------------------------------------------------------
% Input(s): 	fullfilename	- full file name with the path
% Output(s):	filename	- filename without path
% Usage:	filename = ig_strip_path(fullfilename);
%
% Last modified 13.06.03
% Copyright (c) 2003 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

PATHDIV = '\';
i = strfind(fullfilename,PATHDIV);

if ~isempty(i),
	filename = fullfilename(max(i)+1:end);
else
	filename = fullfilename;
end

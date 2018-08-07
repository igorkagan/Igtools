function filename=strip_path(fullfilename)
mfile_name = mfilename; disp_ig_warning(mfile_name);

% strip_path	- remove path from full filename
%--------------------------------------------------------------------------------
% Input(s): 	fullfilename	- full file name with the path
% Output(s):	filename	- filename without path
% Usage:	filename = strip_path(fullfilename);
%
% Last modified 13.06.03
% Copyright (c) 2003 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

PATHDIV = '\';
i = findstr(fullfilename,PATHDIV);

if ~isempty(i),
	filename = fullfilename(max(i)+1:end);
else
	filename = fullfilename;
end

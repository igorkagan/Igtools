function install
mfile_name = mfilename; disp_ig_warning(mfile_name);
% install	- add current directory to MATLAB path
%--------------------------------------------------------------------------------
% Input(s): 	none
% Output(s):	none
% Usage:	install
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% Note: this function will add current directory MATLAB path 
% and save the current MATLAB path in the pathdef.m file.
%--------------------------------------------------------------------------------

addpath(pwd);
rc = path2rc;

if rc == 0
	disp('SUCCESS: the path was saved successfully');
elseif rc == 1
	disp('ERROR: the path could not be saved');
elseif rc == 2
	disp('ERROR: the original pathdef.m was not found');
elseif rc == 3
	disp('ERROR: the original pathdef.m was found but could not be read');
end


      

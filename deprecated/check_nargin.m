function result = check_nargin(fun, narg)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% check_nargin	- checks number of arguments in function
%--------------------------------------------------------------------------------
% Input(s): 	fun 	- function name
% 		narg	- number of arguments
% Output(s):	result	- 1: OK, 0: wrong number of arguments			
% Usage:	result 	= check_nargin(mfilename,nargin);
%
% Last modified 15.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

result = 1;
if narg~=nargin(fun), 
	disp(['===> ' datestr(now)]); 
	disp(['ERROR in file ' fun ' - the number of agruments (' num2str(narg) ') is incorrect (should be ' num2str(nargin(fun)) ').']);
	disp(['Please see function help below.']);
	help(fun);
	result = 0;
end


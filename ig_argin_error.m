function ig_argin_error(fun)
%IG_ARGIN_ERROR		- handles errors in argin
%--------------------------------------------------------------------------------
% Input(s): 	fun 	- function name
% Output(s):	none
% Usage:	ig_argin_error(mfilename);
%
% Last modified 15.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

disp(['===> ' datestr(now)]); 
disp(['ERROR in file ' fun ' - the number of agruments is incorrect. Please see function help below.']);
help(fun);

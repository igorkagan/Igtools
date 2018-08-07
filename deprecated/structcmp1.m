function indout = structcmp1(s1,s2)
mfile_name = mfilename; disp_ig_warning(mfile_name);

% structcmp1	- compares two structures 
% (NOTE: only single level struct works -- i.e. struct fields cannot be struct!)
%--------------------------------------------------------------------------------
% Input(s): 	s1	- structure1
%		s2	- structure2
% 		structures must have same number of fields
%		structures must have same field names
% Output(s):	indout	- array of 0 - not equal / 1 - equal - per each field
% Usage:	indout = structcmp(s1,s2)
%
% Last modified 25.11.01
% Copyright (c) 2001 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

if nargin~=2
	disp('function structcomp takes 2 inputs!');
	help structcomp
	return
end
s1f = fieldnames(s1);
s2f = fieldnames(s2);

if(size(s1f,1)~=size(s2f,1))
	disp('structures must have same number of fields!');	
	help structcomp
	return
end

for i=1:size(s1f,1),
	if ~strcmp(s1f(i),s2f(i)),
		disp('structures must have same field names');	
		help structcomp
		return
	else
		indout(i) = all(getfield(s1,char(s1f(i))) == getfield(s2,char(s1f(i))));
	end
end
			

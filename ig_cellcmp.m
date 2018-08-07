function indout = ig_cellcmp(c1,c2)
%IG_CELLCMP		- compares two cell arrays
%--------------------------------------------------------------------------------
% Input(s): 	c1	- cell array 1
%		c2	- cell array 2
% 		cell arrays must be of equal length
% Output(s):	indout	- array of 0 - not equal / 1 - equal - per element
% Usage:	indout = ig_cellcmp(c1,c2)
%
% Last modified 25.11.01
% Copyright (c) 2001 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

if ~check_nargin(mfilename,nargin), return; end;

% make arrays columns
if size(c1,1)<size(c1,2),
	c1 = c1';
end

if size(c2,1)<size(c2,2),
	c2 = c2';
end

if(size(c1,1)~=size(c2,1))
	disp('cell arrays must have same number of elements!');	
	help cellcmp
	return
end

indout = strcmp(c1,c2);
		

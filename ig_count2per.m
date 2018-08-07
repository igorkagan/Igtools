function cp = ig_count2per(count,total_count)
%IG_COUNT2PER		- convert counts to percentages
%--------------------------------------------------------------------------------
% Input(s): 	counts
% Output(s):	percentages
% Usage:	cp = ig_count2per(count,total_count)
%
% Last modified 18.11.03
% Copyright (c) 2003 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also IG_NUM2PER.
%--------------------------------------------------------------------------------

cp = count/total_count*100;

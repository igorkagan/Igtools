function per = ig_num2per(n,n_total)
%IG_NUM2PER		- convert count to percentages
%--------------------------------------------------------------------------------
% Input(s): 	n  - count
%		n_total - total count
% Output(s):	per - % of n in n_total
% Usage:	per = ig_num2per(n,n_total)
%
% Last modified 18.11.03
% Copyright (c) 2003 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also IG_COUNT2PER.
%--------------------------------------------------------------------------------

per = n*100/n_total;

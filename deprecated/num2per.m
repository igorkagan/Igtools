function per = num2per(n,n_total)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% hist2per	- convert count to percentages
%--------------------------------------------------------------------------------
% Input(s): 	n  - count
%		n_total - total count
% Output(s):	per - % of n in n_total
% Usage:	per = num2per(n,n_total)
%
% Last modified 18.11.03
% Copyright (c) 2003 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

per = n*100/n_total;

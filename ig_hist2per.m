function hp = ig_hist2per(hn)
%IG_HIST2PER		- convert histogram count to percentages
%--------------------------------------------------------------------------------
% Input(s): 	hn - histogram values in counts
% Output(s):	hp - histogram values in % (assuming that sum(hn)=100%)
% Usage:	hp = ig_hist2per(hn)
%
% Last modified 18.11.03
% Copyright (c) 2003 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

hp = hn/sum(hn)*100;

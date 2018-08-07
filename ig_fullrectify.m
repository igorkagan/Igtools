function [out] = ig_fullrectify(in, threshold)
%IG_FULLRECTIFY		- full wave rectification
%--------------------------------------------------------------------------------
% Input(s): 	in - input signal
%		threshold - threshold to rectify by 
%		(optional, default 0 - fullwave-rectification)
% Output(s):	out - rectified input signal
% Usage:	out = fullrectify(in, 0.5) % "over-fullwave-rectified" signal
%
% Last modified 24.06.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also IG_RECTIFY.
%--------------------------------------------------------------------------------

if nargin < 2,
   threshold = 0;
end

out = threshold+(in-threshold).*sign(in-threshold);

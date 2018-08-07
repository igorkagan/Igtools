function [out] = rectify(in, threshold, flag)
mfile_name = mfilename; disp_ig_warning(mfile_name);

% rectify	- rectify the input
%--------------------------------------------------------------------------------
% Input(s): 	in - input signal
%		threshold - threshold to rectify by 
%		(optional, default 0 - half-rectification)
%		flag: 1 - >threshold, -1 - <threshold
% Output(s):	out - rectified input signal
% Usage:	out = rectify(in, 0.5) % over-rectified signal
%
% Last modified 03.11.01
% Copyright (c) 2001 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% Rectification - a function that is zero for membrane potentials 
% below a threshold, and that grows linearly from there on (Carandini et al., 1999).
%
% See also FULLRECTIFY.
%--------------------------------------------------------------------------------

if nargin < 2,
   threshold = 0;
   flag = 1;
end
if nargin < 3,
   flag = 1;
end

if flag==1,
	out = in.*(in>threshold) + threshold.*(in<=threshold);
else
	out = in.*(in<threshold) + threshold.*(in>=threshold);
end

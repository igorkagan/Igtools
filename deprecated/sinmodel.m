function s = sinmodel(beta,x)
mfile_name = mfilename; disp_ig_warning(mfile_name);

% sinmodel	- sine waveform fit (for use with nlinfit)
%--------------------------------------------------------------------------------
% Input(s): 	beta:
%		beta(1)	- temporal frequency (Hz)
%		beta(2)	- phase (rad)
% Output(s):	s	- sine waveform
% Usage:	Later...
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also NLINFIT.
%--------------------------------------------------------------------------------

% Sin fit model
TF = beta(1);
p  = beta(2);

%s = max(sin(2*pi*(1/(1000/TF))*x+p),0); % half-rectified sin
s = (sin(2*pi*(1/(1000/TF))*x+p));

function dist_cm = ig_minarc2cm(vd,dist_minarc);
%IG_MINARC2CM		- convert minarc to cm
%--------------------------------------------------------------------------------
% Input(s): 	vd_cm	- viewing distance (cm)
%		dist_minarc - distance (minacr)
% Output(s):	dist_cm - distance (cm)
% Usage:	dist_cm = ig_minarc2cm(vd,dist_minarc);
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also IG_CM2MINARC, IG_VF.
%--------------------------------------------------------------------------------

if ~check_nargin(mfilename,nargin), return; end;

dist_cm = 2*vd*tan((0.5*dist_minarc)*(pi/180)/60);


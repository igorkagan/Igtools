function dist_cm = deg2cm(vd,dist_deg);
mfile_name = mfilename; disp_ig_warning(mfile_name);
% minarc2cm	- convert minarc to cm
%--------------------------------------------------------------------------------
% Input(s): 	vd_cm	- viewing distance (cm)
%		dist_deg - distance (deg)
% Output(s):	dist_cm - distance (cm)
% Usage:	dist_cm = deg2cm(vd,dist_deg);
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also CM2DEG, VF.
%--------------------------------------------------------------------------------


dist_cm = 2*vd*tan((0.5*dist_deg)*pi/180);


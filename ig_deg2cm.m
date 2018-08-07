function dist_cm = ig_deg2cm(vd,dist_deg);
%IG_DEG2CM		- convert deg to cm
%--------------------------------------------------------------------------------
% Input(s): 	vd	- viewing distance (cm)
%		dist_deg - distance (deg)
% Output(s):	dist_cm - distance (cm)
% Usage:	dist_cm = ig_deg2cm(vd,dist_deg);
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also CM2DEG, VF.
%--------------------------------------------------------------------------------


dist_cm = 2*vd*tan((0.5*dist_deg)*pi/180);


function [e,h,v] = vf(ledx_cm,ledy_cm,sx_minarc,sy_minarc,vd_cm)
mfile_name = mfilename; disp_ig_warning(mfile_name);

% vf		- visual field estimation
%--------------------------------------------------------------------------------
% Input(s): 	ledx_cm		- LED x (cm, from LLC*)
%		ledy_cm		- LED y (cm, from LLC)
%		sx_minarc	- stimulus x (minarc, from LLC)
%		sy_minarc	- stimulus y (minarc, from LLC)
%		vd_cm		- viewing distance (cm)
%		---
%		*LLC - Lower Left Corner of the monitor
%		
%		-or-
%		h_deg 		- horizontal eccentricity (deg)
%		v_deg		- vertical eccentricity	(deg)
%
% Output(s):	h		- horizontal eccentricity (deg)
%		v		- vertical eccentricity	(deg)
%		e		- eccentricity (deg)
% Usage:	[e,h,v] = vf(ledx_cm,ledy_cm,sx_minarc,sy_minarc,vd_cm);
%		e = vf(h_deg, v_deg);
%
% Last modified 15.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also CM2MINARC, MINARC2CM.
%--------------------------------------------------------------------------------

if nargin == 5,
	% LED coordinates in minarc
	ledx_minarc = cm2minarc(vd_cm,ledx_cm);
	ledy_minarc = cm2minarc(vd_cm,ledy_cm);

	h = (sx_minarc - ledx_minarc)/60;
	v = (sy_minarc - ledy_minarc)/60;
	e = sqrt(h^2+v^2);

elseif nargin == 2, % just calculate the eccentricity using hor. and vert. VF coordinates
	e = sqrt(ledx_cm^2+ledy_cm^2);

else
	argin_error(mfilename);
	return;
end





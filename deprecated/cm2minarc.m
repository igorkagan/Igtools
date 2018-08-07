function dist_minarc = cm2minarc(vd_cm,dist_cm);
mfile_name = mfilename; disp_ig_warning(mfile_name);
% cm2minarc	- convert cm to minutes of arc (minarc)
%--------------------------------------------------------------------------------
% Input(s): 	vd_cm	- viewing distance (cm)
%		dist_cm	- distance (cm)
% Output(s):	dist_minarc - distance (minarc)
% Usage:	dist_minarc = cm2minarc(vd_cm,dist_cm);
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also MINARC2CM, VF.
%--------------------------------------------------------------------------------

if ~check_nargin(mfilename,nargin), return; end;
 
coef = 57.3; % at this distance 1 cm is equal to one degree
dist_minarc = 2*atan((dist_cm/2)/vd_cm)/(pi/180)*60; 

% dist_minarc = coef/vd_cm*60*dist_cm;
% dist_minarc = atan(dist_cm/vd_cm)/(pi/180)*60 % wrong!



 


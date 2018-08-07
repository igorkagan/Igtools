function dist_cm = minarc2cm(vd,dist_minarc);
mfile_name = mfilename; disp_ig_warning(mfile_name);
% minarc2cm	- convert minarc to cm
%--------------------------------------------------------------------------------
% Input(s): 	vd_cm	- viewing distance (cm)
%		dist_minarc - distance (minacr)
% Output(s):	dist_cm - distance (cm)
% Usage:	dist_cm = minarc2cm(vd,dist_minarc);
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also CM2MINARC, VF.
%--------------------------------------------------------------------------------

if ~check_nargin(mfilename,nargin), return; end;

dist_cm = 2*vd*tan((0.5*dist_minarc)*(pi/180)/60);


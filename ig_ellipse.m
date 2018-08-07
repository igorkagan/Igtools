function h=ig_ellipse(x,y,a,b,theta,varargin)
%IG_ELLIPSE		- draws ig_ellipse (a,b) at (x,y)
%--------------------------------------------------------------------------------
% Input(s): 	x	- x center
%		y	- y center
%		a	- major axis 
%		b	- minor axis
%		theta	- rotation angle, counterclockwise (deg)
%		varargin- Line properties (as in plot)
% Output(s):	h	- handler to ig_ellipse
% Usage:	ig_ellipse(0,0,1,2,45,'LineWidth',2);
%
% Last modified 16.06.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

if nargin < 2
	x = 0;
	y = 0;
end

if nargin < 4
	a = 1;
	b = 1;
end

if nargin < 5
	theta = 0;
end

theta = theta/180*pi;

R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
fi = 0:0.01:2*pi;
X = a*cos(fi);
Y = b*sin(fi);

Z = R*[X; Y];

h = plot(Z(1,:)+x,Z(2,:)+y,varargin{:});

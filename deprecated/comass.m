function [cx,cy] = comass(x,y)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% comass	- finds center of mass of a uniform density polygon
%--------------------------------------------------------------------------------
% Input(s): 	x, y (or [x; y]) - polygon vertices
% Output(s):	[cx,cy] - coordinates of center of mass
% Usage:	[cx,cy] = comass(x,y);
%
% Last modified 09.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------
%
% Algorithm description:
%
%  cx = Int(x*ds)/Int(ds), where ds - area element
%  and Int{ds} is total Area of a polygon.
%
% According to Green's Theorem, area integral can be reduced to contour integral:
% Area = 1/2*Int(xdy-ydx) [1]
% and using parametrization (x,y) = ( (1-t)*x0 + t*x1,  (1-t)*y0 + t*y1 )
%			    1
% Int(x*ds) = 1/2*Int(x^2*dy)=1/2*Int (x^2*dt*dy) = sum( 1/6*(x1^2+x1*x0+x0^2)*(y1-y0) )
%			    0			(for each edge)
%
% Reducing integral [1] to sum, we get:
%	     N-1	
% Area = 1/2*sum (x_i*y_{i+1} - x_{i+1}*y_{i})
%	     i=0
%	     N-1
% cx = 1/(6*Area)*sum( (x_i + x_{i+1})*(x_i*y_{i+1} - x_{i+1}*y_i) );
%	     i=0
%	     N-1
% cy = 1/(6*Area)*sum( (y_i + y_{i+1})*(x_i*y_{i+1} - x_{i+1}*y_i) );
%	     i=0

if nargin == 0, help comass, return, end;
if nargin == 1, % vertices are in 2D matrix
  	if size(x,1)==2      % 2 by N
    		y = x(2,:); 
		x = x(1,:);
  	elseif size(x,2)==2  % N by 2
    		y = x(:,2); 
		x = x(:,1);
  	else
    		y = imag(x);
    		x = real(x);
  	end
end 

% Make a closed polygon 
x = [x(:); x(1)];
y = [y(:); y(1)];

l = length(x);
if length(y)~=l
	error(' Vectors x and y must be of the same length')
end

A = 1/2*sum( x(1:end-1).*y(2:end) - x(2:end).*y(1:end-1) ); % Area

cx = 1/(6*A)*sum( (x(1:end-1) + x(2:end)).*(x(1:end-1).*y(2:end) - x(2:end).*y(1:end-1)) );

cy = 1/(6*A)*sum( (y(1:end-1) + y(2:end)).*(x(1:end-1).*y(2:end) - x(2:end).*y(1:end-1)) );

if nargout < 2, cx = cx+i*xy; end


function h=make_raster(t,inipos,len,dis,varargin)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% make_raster	- draws raster (short vertical line) plot for spike train
%--------------------------------------------------------------------------------
% Input(s): 	t	- spike arrival times 
%			  t should be vector (one row) or 2D matrix (several rows)
%		inipos	- initial vertical position (optional, default 1)
%		len	- raster line length (optional, default 1)
%		dis	- distance between rows (optional, default 0)
%		varargin- Line properties (as in plot) (optional)
% Output(s):	h	- handler to raster
% Usage:	make_raster(t,inipos,len,dis,varargin);
%
% Last modified 23.11.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------
if nargin < 2,
	inipos = 1;
	len = 1;
	dis = 0;
elseif nargin < 3,
	len = 1;
	dis = 0;
elseif nargin < 4,
	dis = 0;
end

[rows, cols] = size(t);
if min(size(t))==1, t = t(:)'; end

h = [];
for r = 1:rows,
	
	x = zeros(3*cols,1);
	x(1:3:3*cols,1) = t(r,:)';
	x(2:3:3*cols,1) = t(r,:)';
	x(3:3:3*cols,1) = NaN;

	y = zeros(3*cols,1);
	y1 = inipos + (r-1)*ones(cols,1) + (r-1)*dis;
	y2 = inipos + (r-1+len)*ones(cols,1);

	y(1:3:3*cols,:) = y1;
	y(2:3:3*cols,:) = y2;
	y(3:3:3*cols,:) = NaN;

	hh = line(x,y,varargin{:});
	h = [h hh];
end

set(gca,'Ydir','reverse');

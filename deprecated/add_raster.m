function h=add_raster(t,per_of_ylim,len,dis,varargin)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% add_raster	- adds raster (short vertical line) plot for spike train to current axis
%--------------------------------------------------------------------------------
% Input(s): 	t	- spike arrival times: 
%			  t should be vector (one row), or matrix or struct (by row),
%			  or Spk (Unitret spikes format)
%		per_of_ylim	- "percentage" of ylim (optional, default 0.25)
%		len	- raster line length (optional, default 0.8)
%		dis	- distance between rows (optional, default 0.2)
%		varargin- Line properties (as in plot) (optional)
% Output(s):	h	- handler to raster
% Usage:	add_raster(t,0.5,len,dis,varargin);
%
% Last modified 23.11.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------
if nargin < 2,
	per_of_ylim = 0.25;
	len = 0.8;
	dis = 0.2;
elseif nargin < 3,
	len = 0.8;
	dis = 0.2;
elseif nargin < 4,
	dis = 0.2;
end


if ~isempty(t),

	if ~isstruct(t),
		if size(t,2) > 5
			if all(t(:,5)==1 | t(:,5)==0),
				type = 'spk';
				rows = size(t,1);
			end
		else
			if min(size(t))==1, t = t(:)'; end
			[rows, cols] = size(t);
			type = 'matrix';
		end
	else
		t = t(:);
		[rows, cols] = size(t);
		type = 'struct';
	end

	ylim = get(gca,'Ylim');
	if per_of_ylim == 1,	% adding to blank axis
		
		inipos = (len+dis)*rows;
	else
		inipos = ylim(2) + per_of_ylim*(ylim(2)-ylim(1));
	end

	h = [];
	for r = 1:rows,
	
		switch type,
			case 'struct'
				cols = length(t(r).spikes);
				spikes = t(r).spikes;

			case 'matrix'
				spikes = t(r,:);

			case 'spk'
				cols = t(r,2); 
		                To  = t(r,3);
		                spikes   = t(r,6:cols+5)-To;
			
		end
	
		x = zeros(3*cols,1);
		x(1:3:3*cols,1) = spikes';
		x(2:3:3*cols,1) = spikes';
		x(3:3:3*cols,1) = NaN;

		y = zeros(3*cols,1);
		y1 = inipos - (r-1)*len*ones(cols,1) - (r-1)*dis;
		%y2 = inipos - (r-1+len)*ones(cols,1);
		y2 = y1 - len;

		y(1:3:3*cols,:) = y1;
		y(2:3:3*cols,:) = y2;
		y(3:3:3*cols,:) = NaN;

		hh = line(x,y,varargin{:});
		h = [h hh];
	end

	set(gca,'Ylim',[ylim(1) inipos]);
end



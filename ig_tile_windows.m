function ig_tile_windows(hWnd)
%IG_TILE_WINDOWS		- tile MATLAB figure windows
%--------------------------------------------------------------------------------
% Input(s): 	hWnd - vector of handlers to windows 
%		If omitted, all MATLAB figure windows will be tiled.
% Output(s):	none
% Usage:	tileWindows(hWnd);
%		tileWindows(); % tile all windows
%
% Last modified 14.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%
% See also MINIMIZE_WINDOWS, MAXIMAZE_WINDOWS.
%--------------------------------------------------------------------------------

if nargin<1,
	hWnd = get(0,'Children');
	hWnd = sort(hWnd);
elseif nargin>1,
	disp(['ERROR! tileWindows: wrong number (',int2str(nargin),') of arguments.']);
	help ig_tile_windows;
	return
end

n = length(hWnd);
if n ~= size(hWnd,1)*size(hWnd,2),
	disp(['ERROR! tileWindows: hWnd argument should be 1D vector.']);
	help tileWindows;
	return
end

leftSpace	= 5;			% Space from left edge of the screen
figUpperSpace 	= 75; 			% Space for MATLAB figure toolbars
bottomSpace 	= 30;          		% Space below bottom row (Windows toolbar) 
horSpace	= 6;			% Horizontal space between columns

nh = ceil(sqrt(n));         		% Number of windows horisontally.
nv = ceil(n/nh);            		% Number of windows vertically.

set(0, 'Units', 'pixels');             
scrDim = get(0, 'ScreenSize');          
scrW = scrDim(3) - leftSpace - horSpace*nh ;                    	
scrH = scrDim(4) - bottomSpace - figUpperSpace*nv;                     	

width = round(scrW/nh);
height = round((scrH)/nv);


for row = 1:nv
	for col = 1:nh
      		idx = (row-1)*nh + col;
      		if idx <= n
	         	left = leftSpace + (col-1)*(width+horSpace);
	         	bottom = bottomSpace + (row-1)*(height+figUpperSpace);
	         	pos = [left bottom width height];   
	         	set(hWnd(idx), 'Units', 'Pixels');             
	         	set(hWnd(idx), 'Position', pos);  
			figure(hWnd(idx));                          
      		end
   	end
end



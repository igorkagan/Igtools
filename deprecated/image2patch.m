function h=image2patch(X,map)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% image2patch	- converts MATLAB image to collection of patches
%--------------------------------------------------------------------------------
% Input(s): 	X	- image
%		map 	- colormap
% Output(s):	h	- handles to patches
% Usage:	h=image2patch(X,map);
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------


[R,C] = find(X>0);
h = [];
for i=1:length(R),
	hh = fill([C(i) C(i)+1 C(i)+1 C(i) C(i)],[R(i) R(i) R(i)+1 R(i)+1 R(i)], X(R(i),C(i)));
        hold on
        h = [h; hh]; 
end
set(h,'EdgeColor','none');
colormap(map)
	

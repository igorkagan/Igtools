function h = ig_dmplot(x,y,varargin)
%IG_DMPLOT		- double marker plot
%--------------------------------------------------------------------------------
% Input(s): 	as in plot
% Output(s):	as in plot
% Usage:	as plot
%
% Last modified 13.12.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

h(1) = plot(x,y,varargin{:}); hold on;
Marker = get(h,'Marker');
if strcmp(Marker,'none'),
	Marker = 'o';
end
set(h(1),'MarkerSize',10,'MarkerFaceColor','w','Marker',Marker);
h(2) = plot(x,y,varargin{:});
set(h(2),'MarkerSize',5,'MarkerFaceColor','w','LineStyle','none','Marker',Marker);


function d = ig_remove_conditions4anova(d,varargin)
%IG_REMOVE_CONDITIONS4ANOVA		- remove conditions for anova

% varargin: 
% if d is dataset:	pairs of condition name | condition to remove
% e.g.			d = ig_remove_conditions4anova(d,'task',1,'type',0); % task and type are fields in dataset d
% if d is matrix:	pairs of condition index | condition to remove
% e.g.			d = ig_remove_conditions4anova(d,1,1,4,0); % task and type are fields 1 and 4 in dataset d

vt = whos('d');


if  strcmp(vt.class,'dataset')
	for k = 1:2:nargin-1,
		idx_leave = find(d.(varargin{k})~=varargin{k+1});
		d = d(idx_leave,:);
	end	
	
else % matrix
	for k = 1:2:nargin-1,
		idx_leave = find(d(:,varargin{k})~=varargin{k+1});
		d = d(idx_leave,:);
	end
end
	
	
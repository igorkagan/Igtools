function d = ig_replace_conditions4anova(d,varargin)
%IG_REPLACE_CONDITIONS4ANOVA		- replace conditions4anova

% varargin: 
% if d is dataset:	triplets of condition name | condition from | condition to
% e.g.			d = ig_replace_conditions4anova(d,'rew',2,1); % rew 2->1
% if d is matrix:	triplets of condition index | condition from | condition to
% e.g.			d = ig_replace_conditions4anova(d,3,2,1); % rew (field 3) 2->1

vt = whos('d');

if  strcmp(vt.class,'dataset')
	for k = 1:3:nargin-1,
		idx_replace = find(d.(varargin{k}) == varargin{k+1});
		d.(varargin{k})(idx_replace) = repmat(varargin{k+2},length(idx_replace),1);
	end	
	
else % matrix
	for k = 1:3:nargin-1,
		idx_replace = find(d(:,varargin{k}) == varargin{k+1});
		d(idx_replace,varargin{k}) = repmat(varargin{k+2},length(idx_replace),1);
	end
end
	
	
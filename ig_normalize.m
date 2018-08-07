function s = ig_normalize(s,dim,mini,maxi)
%IG_NORMALIZE		- normalize vector or 2D array
% set mini or maxi to [] to omit corresponding normalization

if nargin < 2,
        dim = 1;
end
if nargin < 3,
        mini = 0;
end
if nargin < 4,
        maxi = 1;
end

dims = size(s);
 
if any(dims==1),
	if ~isempty(mini), 
		s = s - min(s);
	end
	if ~isempty(maxi), 
		s = s/max(s);
	end
	if ~isempty(mini) && ~isempty(maxi)
		s = s*(maxi-mini) + mini;
	end
	
elseif length(dims) == 2,
	if ~isempty(mini)
		mins = min(s,[],dim);
		if size(mins,1) == 1, % row
			r = dims(1);
		else
			r = 1;
		end
		s = s - repmat(mins,r,dim);
	end
	if ~isempty(maxi)
		maxs = max(s,[],dim);
		if size(maxs,1) == 1, % row
			r = dims(1);
		else
			r = 1;
		end
		s = s./repmat(maxs,r,dim);
	end
	if ~isempty(mini) && ~isempty(maxi)
		s = s*(maxi-mini) + mini;
	end
	
end


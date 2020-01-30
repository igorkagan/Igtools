function [idx_up, idx_down] = ig_find_threshold_crossings(x,threshold,TOPLOT)
%IG_FIND_THRESHOLD_CROSSINGS		- finds crossings of threshold from below to above up_threshold and from above to below 
% returns indices of paired up-down crossings
% works with different thresholds for up and down, but threshold(1) (up) should be > threshold(2) (down)
% Igor Kagan 2010
% e.g. 
% ig_find_threshold_crossings(rand(1,100),0.7,1)
% ig_find_threshold_crossings(rand(1,100),[0.7 0.3],1)

if nargin < 3,
	TOPLOT = 0;
end

n = length(x);

if length(threshold) == 2,
	t1 = threshold(1);
	t2 = threshold(2);
else
	t1 = threshold;
	t2 = threshold;
end	

idx_up = find(diff(x>t1)>0)+1; % up crossings 
idx_down = find(diff(x>t2)<0)+1; % down crossings 

% make sure we start with idx_up and finish with idx_down in each pair
if ~isempty(idx_up) && ~isempty(idx_down),
	idx_down = idx_down(find(idx_down > idx_up(1)));
% 	if length(idx_up) > length(idx_down), % commented out on 20200130 - not  needed, introduced missed crossings
% 		idx_up =idx_up(1:end-1);
% 	end
else
	
	idx_up = [];
	idx_down = [];
	
end

% select only those idx_down that are preceeded by idx_up
idx_up_m = [idx_up; ones(size(idx_up))];
idx_down_m = [idx_down; -1*ones(size(idx_down))];
idx_m = [idx_up_m idx_down_m];
	
[temp,i] = sort(idx_m(1,:));
idx_m = idx_m(:,i); % re-sort by idx

idx_t1_to_t2 = find(diff([0 idx_m(2,:)])); % idx t1->t2 
idx_m = idx_m(:,idx_t1_to_t2);

idx = idx_m(1,:);

idx_up = idx(idx_m(2,:)==1);
idx_down = idx(idx_m(2,:)==-1);

if length(idx_up) > length(idx_down),
	idx_up =idx_up(1:end-1);
end

if TOPLOT,
	plot(x,'k'); hold on; plot(x,'k.'); 
	line([1 n],[t1 t1],'Color',[1 0 0]);
	line([1 n],[t2 t2],'Color',[0.5 0 0]);
	
	plot(idx_up  ,x(idx_up),  'ro');
	plot(idx_down,x(idx_down),'go');
	
end
	



	


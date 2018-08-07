function ebh = ig_errorbar(x,y,dim,stat,type,varargin)
%IG_ERRORBAR		- errorbar plot

if isempty(y), return; end;


if nargin < 3
	dim = 1;
end

if nargin < 4
	stat = 'sterr';
end

if nargin < 5
	type = 2; % error bar
end

mean_y = mean(y,dim);
if strcmp(stat,'sterr'),
	s_y = sterr(y,dim);
else
	s_y = ig_std(y,dim);
end


if isempty(x),
	x = 1:length(mean_y);
	if size(x,1) ~= size(y,1),
		x = x';
	end
end

if type == 0,
	h_patch = patch([x fliplr(x)],[mean_y+s_y fliplr(mean_y-s_y)],'r'); hold on;
	h_plot = plot(x,mean_y,varargin{:});
	MarkerEdgeColor = get(h_plot,'MarkerEdgeColor');
	MarkerFaceColor = get(h_plot,'MarkerFaceColor');
	Color = get(h_plot,'Color');
	if ~strcmp(MarkerFaceColor,'none'),
		set(h_patch,'EdgeColor',MarkerEdgeColor,'FaceColor',MarkerFaceColor,'FaceAlpha',0.5);
	else
		set(h_patch,'EdgeColor',Color,'FaceColor',Color,'FaceAlpha',0.5);
		
	end
elseif type == 1,
	plot(x,mean_y,varargin{:},'LineWidth',2); hold on;
	plot(x,mean_y-s_y,varargin{:},'Marker','none','LineWidth',0.5);
	plot(x,mean_y+s_y,varargin{:},'Marker','none','LineWidth',0.5);
	
elseif type == 2,
	ebh = errorbar(x,mean_y,s_y); hold on;
	set(ebh,varargin{:},'Marker','none');
	plot(x,mean_y,varargin{:});
	
elseif type == 3, % bar plot
	
	bar(x,mean_y,varargin{:}); hold on;
	ebh = errorbar(x,mean_y,s_y,'o'); hold on;
	% set(ebh,varargin{:},'Marker','none');
	set(ebh,'Color',[0 0 0],'Marker','none');
	
	
elseif type == -1, % no errorbar
	plot(x,mean_y,varargin{:});
end

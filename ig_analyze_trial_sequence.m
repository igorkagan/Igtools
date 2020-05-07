function out = ig_analyze_trial_sequence(varargin)
%IG_ANALYZE_TRIAL_SEQUENCE		- analyze trial sequence
%
% USAGE:
% ig_analyze_trial_sequence('seq',DAT,'condition_labels',{{'In_l' 'In_r' 'Ch_l' 'Ch_r' 'F L' 'F R' 'F'}},'group_conditions',{{[3 4]}});
% IMPORTANT NOTE: cell inputs should be encapsulated in additional curled brackets {}! (as above)
% out = ig_analyze_trial_sequence('seq',seq,'condition_labels',{{'L' 'R'}});
% ig_analyze_trial_sequence; % use built-in examples (see "Examples")
%
% INPUTS:
%		inputs		- see defaults and examples
%		separare runs should be separared by 0 in the seq
%
% OUTPUTS:
%		out		- .Ppc (probability of preceeding given current)
%				- .Pnc (probability of next given current)
%
% REQUIRES:	Igtools
%
% See also TESTSIM_TRIAL_SEQ_PROB (https://github.com/dagdpz/testsim)
%
%
% Author(s):	I.Kagan, DAG, DPZ
% URL:		http://www.dpz.eu/dag
%
% Change log:
% 20170528:	Created function (Igor Kagan)
% 
% $Revision: 1.0 $  $Date: 2017-05-28 18:09:10 $
%%%%%%%%%%%%%%%%%%%%%%%%%[DAG mfile header version 1]%%%%%%%%%%%%%%%%%%%%%%%%% 

% defaults
param.dataset_name		= '';
param.all_conditions		= [];
param.condition_labels		= {};
param.conditions2exclude	= [];
param.group_conditions		= {}; % conditions within each group will be compared
param.group_condition_names	= {}; 
param.combine_conditions	= {}; 
param.combine_condition_names	= {};
param.conditions_compare_vs_LR	= []; % conditions to compare to preceeding/next left/right conditions
param.group_LR			= {}; % two groups, one left and one right (can also include conditions_compare_vs_LR) 


if nargin == 1, % just sequence or struct
	if isstruct(varargin{1}), % struct containing appropriate fields, at least .seq

		struct_fieldnames = fieldnames(varargin{1});
		n_fields =length(struct_fieldnames);
		
		for k = 1:n_fields
			param.(struct_fieldnames{k}) = varargin{1}.(struct_fieldnames{k});
		end
		
		if isempty(param.all_conditions),
			param.all_conditions =unique(param.seq);
		end
		
		if isempty(param.condition_labels),
			param.condition_labels = cellstr(num2str(param.all_conditions(:)));
		end
		
	else % only sequence was supplied
		param.seq = varargin{1};
		param.all_conditions = unique(param.seq);
		param.condition_labels = cellstr(num2str(param.all_conditions(:)));
	end
	
elseif nargin > 0 % pairs of names/vales
	s = struct(varargin{:});
	
	struct_fieldnames = fieldnames(s);
	n_fields =length(struct_fieldnames);
	
	for k = 1:n_fields
		param.(struct_fieldnames{k}) = s.(struct_fieldnames{k});
	end
	
	if isempty(param.all_conditions),
		param.all_conditions =unique(param.seq);
	end
	
	if isempty(param.condition_labels),
		param.condition_labels = cellstr(num2str(param.all_conditions(:)));
	end
end

n_runs = 1;

if nargin < 1, % Examples
param.dataset_name		= 'test';	
param.all_conditions		= [1 2 3 4 5 6];
param.condition_labels		= {'one' 'two' 'three' 'four' 'five' 'six'};
param.conditions2exclude	= [];
param.group_conditions		= {[1 2]};		% {[1 2] [3 4]}; % only two per group
param.group_condition_names	= {}; % {'group1'}; 	% {'group1' 'group2'}; % 
param.combine_conditions	= {};
param.combine_condition_names	= {};
% param.combine_conditions	= {[4 5]};
% param.combine_condition_names	= {'4 and 5'};
param.conditions_compare_vs_LR	= [1 2 3]; % conditions to compare to preceeding/next L or R conditions
param.group_LR			= {[1 3 5] [2 4 6]}; % two groups, one left and one right (can also include conditions_compare_vs_LR) 

param.seq			= [2 1 3 4 5 6 1 2 2 3 4 5 6 1 3 4 1 2 2 3 4 2 6 2 1 2]; % 1 (L choice) is always preceeded by [2 4 6] (R)
% param.seq			= [1 2 1 2 3 4 5 4 2 2 1 2 1 2 1 2 1 2 3 4 4 5 2 3 4 5 5 2 3 1 2 1 2 1 2 1 2 3 1 2 1 2 2 3 3 3 3 3 1 2 1 2 1 2 6 6]; % 1 is always followed by 2
% param.seq			= [1 2 1 2 3 4 5 4 2 2 1 2 1 2 1 2 1 2 3 4 4 5 2 3 4 5 5 2 3 0 1 2 1 2 1 2 1 2 3 1 2 1 2 2 3 3 3 3 3 1 2 1 2 1 2 6 6]; % 1 is always followed by 2, two runs

% param.seq			= [1 1 2 2 2 2 2 2 2 2 2 1 1 2 2 2 2 2 2 2 2 2 2];
%	prob. of 1 preceeded by 1 = 0.66; prob. of 1 preceeded by 2 = 0.33; prob. of 2 preceeded by 1 = 0.1; prob. of 2 preceeded by 2 = 0.9;
%	prob. of 1 followed by 1 = 0.5; prob. of 1 followed by 2 = 0.5; prob. of 2 followed by 1 = .06; prob. of 2 followed by 2 = 0.94;

% param.seq = randi(6,10000,1);
% param.seq = [randi(6,20,1)' 0 randi(6,15,1)']; % two runs, separated by "0"

end % of examples

[dataset_name all_conditions condition_labels conditions2exclude group_conditions group_condition_names combine_conditions combine_condition_names conditions_compare_vs_LR group_LR seq] = ...
	ig_return_struct_fields(param); % convert to separate variables for convenience



if any(seq==0), % multiple runs/blocks, replace 0 with NaN condition that will be excluded
	n_runs = sum(seq==0)+1;
	seq(seq==0) = NaN;
	all_conditions = [all_conditions(all_conditions~=0)];
	condition_labels = condition_labels(~strcmp(condition_labels,'0'));
end
	

if min(all_conditions)~=1 || max(diff(all_conditions))~=1,
	% error('conditions are not consecutive integer numbers, use ig_vector_to_consecutive_integers.m');
	% TODO: convert conditions automatically so that min is 1 and they are consecutive integer numbers
	
	
end

n_cond			= length(all_conditions);
n_cond_included		= n_cond - length(conditions2exclude);

% exclude conditions
if ~isempty(conditions2exclude),
	for k = conditions2exclude,
		seq(seq==k)= [];
	end
	condition_labels_included = condition_labels(setdiff([1:n_cond],conditions2exclude));
else
	condition_labels_included = condition_labels;
	
end

% combine conditions
if ~isempty(combine_conditions)
	for k = 1:size(combine_conditions,2),
		conds = combine_conditions{k};
		for c = 1:length(conds),
			if c==1,
				condition_labels(conds(c)) = combine_condition_names(k);
			else
				condition_labels(conds(c)) = {' '};
				seq(seq==conds(c)) = conds(1);
				% n_cond = n_cond - 1;
			end
		end
	end
end

n_trials = length(seq(~isnan(seq)));

% Plotting
if length(group_conditions)>2	
	n_rows = 6;
else
	n_rows = 5;
end
n_cols = 4;
	

ig_figure('Position',[100 100 1500 1000],'Name',dataset_name);

subplot(n_rows,n_cols,[1 2 3 4])
% sequence
col = hsv(n_cond); % including excluded conditions :)

plot(seq,'k-'); hold on
for k=1:n_cond,
	idxcond = find(seq == all_conditions(k));
	plot(idxcond,seq(idxcond),'s','MarkerEdgeColor',col(k,:));
end
set(gca,'YTick',all_conditions,'YTickLabel',condition_labels,'Xlim',[0 length(seq)],'Ylim',[0 n_cond+1]);
xlabel('trial #');
title(sprintf('sequence: %d runs %d trials',n_runs,n_trials));

subplot(n_rows,n_cols,[5 6])
% difference
plot(diff(seq),'ko-');
xlabel('trial #');
title('sequence difference');
set(gca,'Xlim',[0 length(seq)]);

subplot(n_rows,n_cols,[7 8])
% autocorrelation
[acorr,acorr_lags] = xcorr(seq(~isnan(seq)),25,'coeff');
stem(acorr_lags,acorr);
set(gca,'Xlim',[acorr_lags(1) acorr_lags(end)]);
xlabel('lag');
title('sequence autocorrelation');


% Probability analysis
[Ppc(1:n_cond,1:n_cond)] = zeros(n_cond,n_cond);
[Pnc(1:n_cond,1:n_cond)] = zeros(n_cond,n_cond);

% probability of ***preceding*** conditions for each current condition
for k = 2:length(seq)
	if ~isnan(seq(k)) && ~isnan(seq(k-1))
		Ppc(seq(k),seq(k-1)) = Ppc(seq(k),seq(k-1)) + 1;
	end
end


% probability of ***next*** condition given current condition
for k = 1:length(seq)-1
	if ~isnan(seq(k)) && ~isnan(seq(k+1))
		Pnc(seq(k),seq(k+1)) = Pnc(seq(k),seq(k+1)) + 1;
	end
end

for c = 1:n_cond
	Ppc(c,:) = Ppc(c,:)/sum(Ppc(c,:));
	Pnc(c,:) = Pnc(c,:)/sum(Pnc(c,:));
end

Ppc(conditions2exclude,:) = NaN;
Pnc(conditions2exclude,:) = NaN;
Ppc(:,conditions2exclude) = NaN;
Pnc(:,conditions2exclude) = NaN;


subplot(n_rows,n_cols,9)
pcolor([[Ppc nan(size(Ppc,1),1)] ; nan(1,size(Ppc,2)+1)]); set(gca,'Ydir','reverse','YTick',all_conditions+0.5,'YTickLabel',condition_labels,'XTick',all_conditions+0.5,'XTickLabel',condition_labels); 
caxis([0 1]); colorbar;
title('P(preceding|current)');
xlabel('preceding');
ylabel('current');

subplot(n_rows,n_cols,10)
pcolor([[Pnc nan(size(Pnc,1),1)] ; nan(1,size(Pnc,2)+1)]); set(gca,'Ydir','reverse','YTick',all_conditions+0.5,'YTickLabel',condition_labels,'XTick',all_conditions+0.5,'XTickLabel',condition_labels);
caxis([0 1]); colorbar;
title('P(next|current)');
xlabel('next');
ylabel('current');

% Probability of certain conditions after left and right responses
if ~isempty(conditions_compare_vs_LR),
	n_conditions_compare_vs_LR = length(conditions_compare_vs_LR);

	[Ppc_LR(1:n_conditions_compare_vs_LR,1:2)] = zeros(n_conditions_compare_vs_LR,2);
	[Pnc_LR(1:n_conditions_compare_vs_LR,1:2)] = zeros(n_conditions_compare_vs_LR,2);
		
	for c=1:n_conditions_compare_vs_LR,
		
		% probability of ***preceding L/R*** conditions for each current condition
		for k = 2:length(seq)
			if ~isnan(seq(k)) && ~isnan(seq(k-1)) && seq(k)==conditions_compare_vs_LR(c)
				if any(seq(k-1) == group_LR{1})
					Ppc_LR(c,1) = Ppc_LR(c,1) + 1;
				elseif any(seq(k-1) == group_LR{2})
					Ppc_LR(c,2) = Ppc_LR(c,2) + 1;
				end		
			end
		end
				
		% probability of ***next L/R*** condition given current condition
		for k = 1:length(seq)-1
			if ~isnan(seq(k)) && ~isnan(seq(k+1)) && seq(k)==conditions_compare_vs_LR(c)
				if any(seq(k+1) == group_LR{1})
					Pnc_LR(c,1) = Pnc_LR(c,1) + 1;
				elseif any(seq(k+1) == group_LR{2})
					Pnc_LR(c,2) = Pnc_LR(c,2) + 1;
				end	
			end
		end
		
	end
	
	% run Binomial test on significance of propotion difference from proportion expected by overall L/R ratio
	
	L_group_n = sum(ismember(seq,group_LR{1}));
	R_group_n = sum(ismember(seq,group_LR{2}));
	LR_group_prop = L_group_n/(L_group_n + R_group_n);
	
	
	Ppc_LR_P=myBinomTest(Ppc_LR(:,1),Ppc_LR(:,1)+Ppc_LR(:,2),LR_group_prop);
	Pnc_LR_P=myBinomTest(Pnc_LR(:,1),Pnc_LR(:,1)+Pnc_LR(:,2),LR_group_prop);

	for c = 1:n_conditions_compare_vs_LR,
		Ppc_LR(c,:) = Ppc_LR(c,:)/sum(Ppc_LR(c,:));
		Pnc_LR(c,:) = Pnc_LR(c,:)/sum(Pnc_LR(c,:));
	end
	
	subplot(n_rows,n_cols,11)
	pcolor([[Ppc_LR nan(size(Ppc_LR,1),1)] ; nan(1,size(Ppc_LR,2)+1)]); set(gca,'Ydir','reverse','YTick',[1:n_conditions_compare_vs_LR]+0.5,'YTickLabel',condition_labels(conditions_compare_vs_LR),'XTick',[1 2]+0.5,'XTickLabel',{'L' 'R'}); 
	caxis([0 1]); colorbar;
	title(sprintf('P(preceding L/R|current) p(Binom)=%s',mat2str(Ppc_LR_P,2)));
	xlabel('preceding L/R');
	ylabel('current');

	subplot(n_rows,n_cols,12)
	pcolor([[Pnc_LR nan(size(Pnc_LR,1),1)] ; nan(1,size(Pnc_LR,2)+1)]); set(gca,'Ydir','reverse','YTick',[1:n_conditions_compare_vs_LR]+0.5,'YTickLabel',condition_labels(conditions_compare_vs_LR),'XTick',[1 2]+0.5,'XTickLabel',{'L' 'R'}); 
	caxis([0 1]); colorbar;
	title(sprintf('P(next L/R|current) p(Binom)=%s',mat2str(Pnc_LR_P,2)));
	xlabel('next L/R');
	ylabel('current');
	
else
	
	Ppc_LR = [];
	Pnc_LR = [];
end


% group conditions, compare conditions within each group
if ~isempty(group_conditions),
	
	if isempty(group_condition_names),
		for g = 1:size(group_conditions,2),
			group_condition_names{g} = mat2str(group_conditions{g});
		end
	end
			
	
	for g = 1:size(group_conditions,2), % for each group
		conds = group_conditions{g}; % should be two conditions (e.g. L and R)
		
		c1c2 = seq(seq==conds(1) | seq==conds(2) | isnan(seq)); % including NaNs separating runs
		c1c2_= seq(seq==conds(1) | seq==conds(2)); % without NaNs
		c1_n = length(find(seq==conds(1)));
		c2_n = length(find(seq==conds(2)));
		c2_prop = c2_n/(c1_n + c2_n);
		
		subplot(n_rows,n_cols,[13 14 15 16])
		plot(c1c2_,'-','Color',mean(col(conds,:),1)); hold on;
		plot(ig_running_average(c1c2_,hanning(10)),':','Color',mean(col(conds,:),1),'LineWidth',2);
		line([1 length(c1c2_)],conds(1)+[c2_prop c2_prop],'LineStyle','--','Color',mean(col(conds,:),1));
		text(length(c1c2_),conds(1)+c2_prop,sprintf('%s to %s: %.2f ', condition_labels{conds(2)}, condition_labels{conds(1)}, c2_prop ));
		
		
		% Probability analysis within each group
		[Ppc_g(1:n_cond,1:n_cond)] = zeros(n_cond,n_cond);
		[Pnc_g(1:n_cond,1:n_cond)] = zeros(n_cond,n_cond);
		
		% probability of ***preceding*** conditions for each current condition
		
		
		for k = 2:length(c1c2)
			if ~isnan(c1c2(k)) && ~isnan(c1c2(k-1))
				Ppc_g(c1c2(k),c1c2(k-1)) = Ppc_g(c1c2(k),c1c2(k-1)) + 1;
			end
		end
		
		% run Fisher's exact test on significant difference from proportions due to choice bias
		Ppc_g_P = fexact( [ zeros(1,Ppc_g(conds(1),conds(1))) ones(1,Ppc_g(conds(2),conds(1))) zeros(1,Ppc_g(conds(1),conds(2))) ones(1,Ppc_g(conds(2),conds(2)))]',...
			[zeros(1,Ppc_g(conds(1),conds(1))+Ppc_g(conds(2),conds(1))) ones(1,Ppc_g(conds(1),conds(2))+Ppc_g(conds(2),conds(2))) ]' );

		
		for c = conds
			Ppc_g(c,:) = Ppc_g(c,:)/sum(Ppc_g(c,:));
		end
		
		
		% probability of ***next*** condition given current condition
		for k = 1:length(c1c2)-1
			if ~isnan(c1c2(k)) && ~isnan(c1c2(k+1))
				Pnc_g(c1c2(k),c1c2(k+1)) = Pnc_g(c1c2(k),c1c2(k+1)) + 1;
			end
		end
		
		% run Fisher's exact test on significant difference from proportions due to choice bias
		Pnc_g_P = fexact( [ zeros(1,Pnc_g(conds(1),conds(1))) ones(1,Pnc_g(conds(2),conds(1))) zeros(1,Pnc_g(conds(1),conds(2))) ones(1,Pnc_g(conds(2),conds(2)))]',...
			[zeros(1,Pnc_g(conds(1),conds(1))+Pnc_g(conds(2),conds(1))) ones(1,Pnc_g(conds(1),conds(2))+Pnc_g(conds(2),conds(2))) ]' );

		
		for c = conds
			Pnc_g(c,:) = Pnc_g(c,:)/sum(Pnc_g(c,:));
		end
		
		Ppc_g = Ppc_g(conds,conds);
		Pnc_g = Pnc_g(conds,conds);
			
		
		out.group_conditions(g).group_conditions	= group_conditions;
		out.group_conditions(g).group_condition_names	= group_condition_names(g);
		
		out.group_conditions(g).Ppc_g = Ppc_g;
		out.group_conditions(g).Pnc_g = Pnc_g;
		
		out.group_conditions(g).c2_prop = c2_prop;
		
		out.group_conditions(g).Ppc_g_P = Ppc_g_P;
		out.group_conditions(g).Pnc_g_P = Pnc_g_P;
		

		subplot(n_rows,n_cols,17+2*(g-1))
		pcolor([[Ppc_g nan(size(Ppc_g,1),1)] ; nan(1,size(Ppc_g,2)+1)]); set(gca,'Ydir','reverse','YTick',[1 2]+0.5,'YTickLabel',condition_labels(conds),'XTick',[1 2]+0.5,'XTickLabel',condition_labels(conds));
		caxis([0 1]); colorbar;
		title([group_condition_names(g) sprintf(' P(preceding|current) p(Fisher)=%.2f',Ppc_g_P)]);
		xlabel('preceding');
		ylabel('current');
		
		subplot(n_rows,n_cols,17+2*(g-1)+1)
		pcolor([[Pnc_g nan(size(Pnc_g,1),1)] ; nan(1,size(Pnc_g,2)+1)]); set(gca,'Ydir','reverse','YTick',[1 2]+0.5,'YTickLabel',condition_labels(conds),'XTick',[1 2]+0.5,'XTickLabel',condition_labels(conds));
		caxis([0 1]); colorbar;
		title([group_condition_names(g) sprintf(' P(next|current) p(Fisher)=%.2f',Pnc_g_P)]);
		xlabel('next');
		ylabel('current');
	end
end

out.param = param;
out.Ppc = Ppc;
out.Pnc = Pnc;
out.Ppc_LR = Ppc_LR;
out.Pnc_LR = Pnc_LR;

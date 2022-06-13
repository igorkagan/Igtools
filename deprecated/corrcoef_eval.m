function [r,sig] = corrcoef_eval(s1,s2,verbose,p,mode)
% corrcoef_eval	- corrcoef and evaluate significance of correlation
%--------------------------------------------------------------------------------
% Input(s): 	
%       s1      - input sample 1
%		s2      - input sample 2
% 		verbose - display output (1) or not (0) (optional, default 1)
% 		p       - significance level - alpha (optional, default 0.05)
%		mode	- test:	'Pearson', 'Spearman' (optional, default 'Pearson')
% Output(s):	
%       r	- coefficient of correlation
%		sig	- significance of correlation (p value)
% Usage:	[r,s] = corrcoef_eval(s1,s2,0,0.01);
%
% 
% Igor Kagan 2022
% NOTE: this function supersedes corrcoef_eval from NaN toolbox, providing same functionality
% It is placed in \deprecated for consistency with naming (no ig_prefix)
%--------------------------------------------------------------------------------


if nargin < 3,
    verbose = 1;
    p = 0.05;
    mode = 'Pearson';
elseif nargin < 4,
    p = 0.05;
    mode = 'Pearson';
elseif nargin < 5;
    mode = 'Pearson';
end

N = length(s1);
s1 = s1(:);
s2 = s2(:);

[r,sig] = corr(s1,s2,'type',mode,'rows','pairwise');


if sig < p,
    sig_string = ['significant (p<',num2str(p),', n=',num2str(N),')'];
else
    sig_string = ['not significant (p>',num2str(p),', n=',num2str(N),')'];
end


if verbose,
    disp(sprintf('correlation between %s and %s: %0.3f is %s',inputname(1),inputname(2),r,sig_string));
end


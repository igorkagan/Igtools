function [h,p,t] = testt_norawdata(m1,m2,s1,s2,n1,n2,tst,alpha,tail,verbose)
%Student's t test for unpaired or paired samples.
%This file is applicable for equal or unequal sample sizes for unpaired
%samples.
%Testt requires powerStudent by Trujillo-Ortiz, A. and R. Hernandez-Walls. 
%URL http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=2907&objectType=file
%
% Syntax: 	TESTT(X1,X2,TST,ALPHA,TAIL)
%      
%     Inputs:
%           X1 and X2 - data vectors. 
%           TST - unpaired t test using standard deviation (0), paired t test using standard deviation (1), or unpaired t test using standard errors (2) (default = 0).
%           ALPHA - significance level (default = 0.05).
%           TAIL - 1-tailed test (1) or 2-tailed test (2). (default = 2).
%     Outputs:
%           - t value.
%           - degrees of freedom.
%           - Confidence interval of means difference (for paired test)
%           - Critical value
%           - p-value
%
%      Example: 
%
%           X1=[77 79 79 80 80 81 81 81 81 82 82 82 82 83 83 84 84 84 84 85 ...
%           85 86 86 87 87];
%
%           X2=[82 82 83 84 84 85 85 86 86 86 86 86 86 86 86 86 87 87 87 88 ...
%           88 88 89 90 90];
%
%           Calling on Matlab the function: testt(X1,X2) - unpaired test
%
%           Answer is:
%
%           t value: 5.2411
%           Degrees of freedom: 48
%           Critical value at 95% (2-tailed test): 2.0106
%           Probability (p-value) that the observed difference is accidental: 0.0000
%           It is a two-tailed hypothesis test.
%           (The null hypothesis was statistically significative.)
%    
%           Power is: 0.9989
%
%           Created by Giuseppe Cardillo
%           CEINGE - Advanced Biotechnologies
%           Via Comunale Margherita, 482
%           80145
%           Napoli - Italy
%           cardillo@ceinge.unina.it


%Input Error handling
if nargin < 10,
        verbose = 0;
end
if nargin < 9,
        tail = 2;
end
if nargin < 8,
        alpha = 0.05;
end
if nargin < 7,
        tst = 0;
end
        

switch tst
    case 0 % unpaired test using standard deviation
        n=[n1 n2]; %samples sizes
        gl=sum(n)-2; %degrees of freedom
        m=[m1 m2]; %samples means
        ds=[s1 s2];  %samples standard deviations
        s=sum((n-1).*ds.^2)/(sum(n)-2); %combined standard deviation
        dm=diff(m); %Difference of means
        denom=sqrt(sum(s./n));
        clear n m ds s %clear unnecessary variables
        
    case 1 % paired test using standard deviation
        n=n1; %samples size
        gl=n-1; %degrees of freedom
        d=x1-x2; %samples difference
        dm=m1-m2; %mean of difference
        denom=sqrt((sum((d-dm).^2))/(n*(n-1))); %standard error of difference
        clear n d %clear unnecessary variables
        
    case 2 % unpaired test using standard errors
        n=[n1 n2]; %samples sizes
        gl=sum(n)-2; %degrees of freedom
        m=[m1 m2]; %samples means
        ds=[s1 s2];  %samples standard errors
        dm=diff(m); %Difference of means
        denom=sqrt(s1^2 + s2^2);
        clear n m ds %clear unnecessary variables
end

t=abs(dm)/denom; %t value
vc=tinv(1-alpha/tail,gl); %critical value
lf=(1-alpha)*100;
p=(1-tcdf(t,gl))*tail; %t-value associated p-value

if p<alpha,
        h=1;
else
        h=0;
end

%display results
if tst==1
    if verbose, fprintf('Mean of difference: %0.4f\n',abs(dm)); end
    ic=[abs(dm)-vc abs(dm)+vc]; %Confidence interval
    if verbose, fprintf('Mean of difference confidence interval at %d%%: %0.4f %0.4f\n',lf,ic); end
end
if verbose,
        fprintf('t value: %0.4f\n',t);
        fprintf('Degrees of freedom: %d\n',gl);
        fprintf('Critical value at %d%% (%d-tailed test): %0.4f\n',lf,tail,vc);
        fprintf('Probability (p-value) that the observed difference is accidental: %0.4f\n',p);
        powerStudent(t,gl,tail,alpha);
end
return

function checkv(x1,x2) %check if x1 and x2 are vectors
if (min(size(x1)) > 1 || min(size(x2)) > 1)
   error('TESTT requires vector rather than matrix data.');
end 
return

function checkt(tst) 
if (numel(tst)>1)%check if tst is a scalar
    error('Warning: it is required a scalar TST value.');
end
if (isnan(tst) || (tst ~= 0 && tst ~= 1))%check if tst is 0 or 1
    error('Warning: TST must be 0 for unpaired test or 1 for paired test.')
end
return

function checka(alpha)
if (numel(alpha)>1)%check if alpha is a scalar
    error('Warning: it is required a scalar ALPHA value.');
end
if (isnan(alpha) || alpha <= 0 || alpha >= 1)%check if alpha is between 0 and 1
    error('Warning: ALPHA must be comprised between 0 and 1.')
end        
return

function checkta(tail)
if (numel(tail)>1)%check if tail is a scalar
    error('Warning: it is required a scalar TAIL value.');
end
if (isnan(tail) || (tail ~= 1 && tail ~= 2))%check if tail is 1 or 2
    error('Warning: TAIL must be 1 for 1-tailed test or 2 for 2-tailed test.')
end
return

function checkp(x1,x2)
if ((numel(x1) ~= numel(x2))),
   error('Warning: for paired test TESTT requires the data vectors to have the same number of elements.');
end
return
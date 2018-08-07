function [nullHypothesis, outlierIndex] = test_binomial_proportions(n, k, p0, alphaValue, useExactTest) 
% @brief test_binomial_proportions tests whether all given binomial
% proportions come from the given binomial distribution; it also detects
% proportions that do not correspond to this distribution.
%
% INPUT
%   - n - m-element vector containing number of observations for each proportion; 
%   - k - m-element vector containing number of successes for each proportion; 
%   - p0 - scalar, probability of successes for the assumed binomial distribution; 
%   - alphaValue - significance level (by default alphaValue = 0.05);
%   - useExactTest - whether exact or approximate test is used for overall testing.
%     Exact test is more effective but also slower (by default useExactTest = false)
% OUTPUT:
%   - nullHypothesis - true if all proportions come from the assumed binomial distribution;
%   - outlierIndex - indices of proportions that do not come from the assumed distribution;
%
% REFERENCES
% [1] Krishnamoorthy, K., Thomson, J. and Cai, Y., 2004. 
% An exact method of testing equality of several binomial proportions to a specified standard. 
% Computational statistics & data analysis, 45(4), pp.697-707.
%
% EXAMPLE of use 
%{
p0 = 0.5; % assumed probability of success is p0 = 0.5 
alphaValue = 0.05;  
m = 10;   % we will have 10 observation samples

nRun = 10; % repeat the test 10 times
nullHypothesis = zeros(1,nRun);
outlierIndex = cell(1, nRun);
for i = 1:nRun
  n = 20 + randi(80, m, 1); % generate observation samples of random size from 20 to 100
  k = binornd(n, p0);       % for each sample generate probabilities of successes
  [nullHypothesis(i), outlierIndex{i}] = test_binomial_proportions(n, k, p0, alphaValue, true);
end
% Since proportions indeed come from binomial random generator with probability of 
% successes p0, in most cases nullHypothesis should be 1 and outlierIndex -- empty
%}
%
% @author Anton Unakafov
% @date 07.11.2017
% @email antonunakafov(at)hotmail.com
% https://de.mathworks.com/matlabcentral/fileexchange/64987-an-exact-test-for-equality-of-several-binomial-proportions-to-a-specified-standard

  if (nargin < 5)
    useExactTest = false;    
    if (nargin < 4)  
      alphaValue = 0.05;
    end
  end  
  m = length(n);  
  if (iscolumn(n))
    n = n';
  end  
  if (iscolumn(k))
    k = k';
  end  
  
  approxTestStat = approximateTestStatistic(k, n, p0);  
  if (useExactTest)
    if (m <= 5)
      exectTestStat = computeTotalPvalue(n, p0, approxTestStat);
    else
      exectTestStat = estimateTotalPvalue(n, p0, approxTestStat);
    end  
    nullHypothesis = (exectTestStat > alphaValue); 
  else
    % reject H0 if PR(chi^2_m > approxTestStat) <= alpha?
    nullHypothesis = (1 - chi2cdf(approxTestStat, m) > alphaValue); 
  end  
  % test each individual proportion
  confInervalLeft = zeros(1, m);
  confInervalRight = zeros(1, m);
  c = 1 - (1 - alphaValue)^(1/m);  
  for i = 1:m
    confInervalLeft(i) = icdf('Beta', c/2, k(i), n(i) - k(i) + 1);
    confInervalRight(i) = icdf('Beta', 1 - c/2, k(i) + 1, n(i) - k(i));
  end
  outlierIndex = find((p0 < confInervalLeft) | (p0 > confInervalRight));    
end  

function pValue = computeTotalPvalue(n, p0, approxTestStatValue)
  x = ones(size(n));
  currDeep = 1;
  pValue = iterateTotalPvalue(x, n, p0, approxTestStatValue, currDeep);
end


function pValue = estimateTotalPvalue(n, p0, approxTestStatValue)
  nMonteCarloIterate = 100000;
  m = length(n); 
  x = zeros(nMonteCarloIterate, m);  
  for i = 1:m
    x(:, i) = binornd(n(i), p0, nMonteCarloIterate, 1);
  end
  n = repmat(n, nMonteCarloIterate, 1);
  xStatisticValue = approximateTestStatistic(x, n, p0);
  pValue = nnz(xStatisticValue >= approxTestStatValue)/nMonteCarloIterate;
end

function pValue = iterateTotalPvalue(x, n, p0, approxTestStatValue, currDeep) 
  m = length(n);
  pValue = 0;
  for i = 1:m
    x(currDeep) = i;  
    dPvalue = 0;
    if (currDeep < m)
      dPvalue = iterateTotalPvalue(x, n, p0, approxTestStatValue, currDeep + 1);
    else %we've reached the last sum
      if (approximateTestStatistic(x, n, p0) >= approxTestStatValue)
        dPvalue = 1;
      end
    end
    pValue = pValue + binopdf(x(currDeep), n(currDeep), p0)*dPvalue;
  end
end

function value = approximateTestStatistic(k, n, p0)
  value = sum( ((k - n*p0).^2) ./ (n*p0*(1-p0)), 2);
end  
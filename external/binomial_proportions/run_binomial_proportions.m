% this script provides three examples demonstrating performance of 
% function test_binomial_proportions
%% test from the paper
p0 = 0.62;
alphaValue = 0.05;
k = [59,107,48];
n = [81,151,114];
[nullHypothesis, outlierIndex] = test_binomial_proportions(n, k, p0, alphaValue, true);
% Expected result: nullHypothesis = 0 (rejected), outlierIndex = 3 
% (third proportion is not likely to come from binomial distribution with p0 = 0.62)

%% testing true binomial proportions (may take several minutes)
p0 = 0.5; % assumed probability of success is p0 = 0.5 
alphaValue = 0.05;  
m = 20;   % we will generate 20 observation samples

nRun = 10; % repeat the test 10 times
nullHypothesis2 = zeros(1,nRun);
outlierIndex2 = cell(1, nRun);
for i = 1:nRun
  n = 20 + randi(80, m, 1); % generate random sizes of observation samples (20 - 100)
  k = binornd(n, p0);       % for each sample generate probabilities of successes
  [nullHypothesis2(i), outlierIndex2{i}] = test_binomial_proportions(n, k, p0, alphaValue, true);
end
% Since proportions indeed come from binomial random generator with probability of 
% successes p0, in most cases nullHypothesis2 should be 1 and outlierIndex2 -- empty


%% testing binomial proportions, one of those is biased  (may take several minutes)
p0 = 0.5;
alphaValue = 0.05;
m = 45;% we will generate 45 observation samples

nRun = 20; % repeat the test 10 times
nullHypothesis3 = zeros(1,nRun);
outlierIndex3 = cell(1, nRun);
indexError = zeros(1,nRun);

nNullHypothesisRejection = 0;  
nCorrectOutlierDetection = 0;
for i = 1:nRun
  n = 20 + randi(80, m, 1); % generate random sizes of observation samples (20 - 100)
  k = binornd(n, p0);       % for each sample generate probabilities of successes
  
  indexError(i) = randi(m); %select one sample by random and make it biased
  if (mod(indexError(i),2))
    k(indexError(i)) = round((1/3)*k(indexError(i))); 
  else
    k(indexError(i)) = round((1/3)*k(indexError(i)) + (2/3)*n(indexError(i))); 
  end  
  [nullHypothesis3(i), outlierIndex3{i}] = test_binomial_proportions(n, k, p0, alphaValue, true);

  if (nullHypothesis3(i) == false) % null hypothesis should be rejected
    nNullHypothesisRejection = nNullHypothesisRejection + 1;
  end 
  
  % one outlier should be detected and it should be the biased proportion
  if (length(outlierIndex3{i}) == 1) && (outlierIndex3{i} == indexError(i))
    nCorrectOutlierDetection = nCorrectOutlierDetection + 1;
  end  
end 
% nNullHypothesisRejection and nCorrectOutlierDetection should be near to nRun
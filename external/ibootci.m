
%  Function File: ibootci
%
%  ci = ibootci(nboot,bootfun,...)
%  ci = ibootci(nboot,{bootfun,...},...,'alpha',alpha)
%  ci = ibootci(nboot,{bootfun,...},...,'bootsam',bootsam)
%  ci = ibootci(nboot,{bootfun,...},...,'mode',mode)
%  [ci,bootstat] = ibootci(...)
%  [ci,bootstat,alpha] = ibootci(...)
%  [ci,bootstat,alpha,bootsam] = ibootci(...)
%
%  Calibrated percentile confidence intervals by iterated bootstrap.
%
%  ci = ibootci(nboot,bootfun,...) computes the 95% iterated bootstrap
%  confidence interval of the statistic computed by bootfun. nboot is a
%  scalar, or vector of upto two positive integers indicating the number
%  of replicate samples for the first and second bootstraps. bootfun is
%  a function handle specified with @, or a string indicating the
%  function name. The third and later input arguments are data (column
%  vectors), that are used to create inputs to bootfun. ibootci creates
%  each bootstrap by sampling with replacement from the rows of the
%  column vector data arguments (which must be the same size). Two-
%  sided percentile confidence intervals [1] are then calibrated to
%  achieve second order accurate coverage [2,3]. The detail of the
%  algorithm used is described clearly in reference [3]. The iterated
%  bootstrap is also commonly referred to as the double bootstrap.
%
%  ci = ibootci(nboot,{bootfun,...},'alpha',alpha) computes the
%  100*(1-alpha) iterated bootstrap confidence interval of the statistic
%  defined by the function bootfun. bootfun and the data that ibootci
%  passes to it are contained in a single cell array. alpha is a scalar
%  between 0 and 1. The default value of alpha is 0.05.
%
%  ci = ibootci(nboot,{bootfun,...},...,'bootsam',bootsam) performs 
%  bootstrap computations using the indices from bootsam for the first 
%  bootstrap. 
%
%  ci = ibootci(nboot,{bootfun,...},...,'mode',mode) performs bootstrap
%  computations in the specified run-mode: 'fast' (vectorized) or 'slow'
%  (loop). The default run-mode is 'fast', which is suitable for most
%  applications with small-to-medium sample sizes. However, running
%  large samples in fast mode may exhaust the available random-access
%  memory (RAM). The problem can be remedied by running ibootci in
%  'slow' mode, which demands much less memory but is significantly
%  slower.
%
%  [ci,bootstat] = ibootci(...) also returns the bootstrapped statistic
%  computed for each of the nboot first bootstrap replicate samples.
%  Each row of bootstat contains the results of applying bootfun to
%  one replicate sample from the first bootstrap.
%
%  [ci,bootstat,alpha] = ibootci(...) also returns the adjusted nominal
%  alpha level following calibration by a second bootstrap. If no
%  bootstrap iteration is called, the nominal alpha level will be no
%  different from the user-specified (or default) alpha level.
%
%  [ci,bootstat,alpha,bootsam] = ibootci(...) also returns bootsam, a 
%  matrix of indices into the rows of the extra arguments. 
%
%  Default values for the number of first and second bootstrap replicate
%  sample sets are 2000 and 200 respectively. With these settings,
%  calibrated coverage levels are rounded up to the nearest percent,
%  which can in effect reduce coverage errors [3]. When the coverage
%  level calibrates to 1, this function returns a warning that it has
%  hit the ends of the bootstrap distribution. This signifies that the
%  returned intervals could have inaccurate coverage. Typically, this
%  situation occurs when the sample size is too small for the specified
%  alpha level. This can vary according to the statistic calculated by
%  bootfun and the number of replicate samples in the second bootstrap.
%
%  Example 1: Two alternatives for 95% confidence intervals of the mean
%    >> y = randn(20,1);
%    >> [ci] = ibootci([2000 200],@mean,y)   
%    >> [ci] = ibootci([2000 200],{@mean,y},'alpha',0.05)
%
%  Example 2: 95% confidence intervals for the means of paired/matched data
%    >> y1 = randn(20,1);
%    >> y2 = randn(20,1);
%    >> [ci1,bootstat,alpha,bootsam] = ibootci([2000 200],{@mean,y1})
%    >> [ci2] = ibootci(2000,{@mean,y2},'bootsam',bootsam,'alpha',alpha)
%
%  Example 5: 95% confidence intervals for the correlation coefficient
%    >> z = mvnrnd([2,3],[1,1.5;1.5,3],20);
%    >> x = z(:,1); y = z(:,2);
%    >> [ci] = ibootci([2000 200],{@corr,x,y})
%
%
%  Bibliography:
%  [1] Efron (1979) Bootstrap methods: another look at the jackknife.
%       Annals of Statistics. 7(1): 1-26
%  [2] Lee and Young (1995) Asympototic Iterated Bootstrap Confidence
%       Intervals. Annals of Statistics. 23(4): 1301-1330.
%  [3] Lee and Young (1999) The effect of Monte Carlo approximation
%       on coverage error of double-bootstrap confidence intervals.
%       Journal of the Royal Statistical Society. Series B. 61(2):
%       353-366
%
%  The syntax in this function code is known to be compatible with
%  recent versions of Octave (v3.2.4 on Debian 6 Linux 2.6.32) and
%  Matlab (v6.5.0 and v7.4.0 on Windows XP).
%     
%  ibootci v1.3 (09/09/2015)
%  Author: Andrew Charles Penn
%  https://www.researchgate.net/profile/Andrew_Penn/
function [ci,bootstat,alpha,idx] = ibootci(argin1,argin2,varargin)
  % Evaluate the number of function arguments
  if nargin<2 || (nargin<3 && ~iscell(argin2))
    error('Too few input arguments');
  end
  if nargout>4
   error('Too many output arguments');
  end
  % Assign input arguments to function variables
  if ~iscell(argin2)
    nboot = argin1;
    bootfun = argin2;
    data = varargin;
    alpha = 0.05;
    mode = 'fast';
    idx = [];
  else
    nboot = argin1;
    bootfun = argin2{1};
    data = {argin2{2:end}}; 
    options = varargin;
    alpha = 1+find(strcmp('alpha',options));
    mode = 1+find(strcmp('mode',options));
    bootsam = 1+find(strcmp('bootsam',options));
    if ~isempty(alpha)
      try
        alpha = options{alpha};
      catch
        alpha = 0.05;
      end
    else
      alpha = 0.05;
    end
    if ~isempty(mode)
      try
        mode = options{mode};
      catch
        mode = 'fast';
      end
    else
      mode = 'fast';
    end
    if ~isempty(bootsam)
      try
        idx = options{bootsam};
        if size(data{1},1) ~= size(idx,1)
          error('Dimensions of data and bootsam are inconsistent')
        end
      catch
        error('Could not find bootsam')
      end
    else
      idx = [];
    end
  end
  if ischar(bootfun)
    % Convert character string of a function name to a function handle
    bootfun = str2func(bootfun);
  end
  iter = numel(nboot);
  nvar = size(data,2);
  % Evaluate function variables
  if iter > 2
    error('Size of nboot exceeds maximum number of iterations supported by ibootci')
  end
  if ~isa(nboot,'numeric')
    error('nboot must be numeric');
  end
  if any(nboot~=abs(fix(nboot)))
    error('nboot must contain positive integers')
  end
  if ~isa(alpha,'numeric') || numel(alpha)~=1 
    error('The alpha value must be a numeric scalar value');
  end
  if alpha<=0 || alpha>=1
    error('The alpha value must be a value between 0 and 1');
  end
  for v = 1:nvar
    varclass(v) = isa(data{v},'double');
    if ndims(data{v})>2
      error('The data must be provided as vectors')
    end
    rows(v) = size(data{v},1);
    cols(v) = size(data{v},2);
  end
  if ~all(varclass)
    error('Data variables must be double precision')
  end
  if any(rows~=rows(1)) || any(cols~=cols(1))
    error('The dimensions of the data are not consistent');
  end
  rows = rows(1);
  cols = cols(1);
  if max(rows,cols) == 1
    error('Cannot bootstrap scalar values');
  elseif cols>1
    % Transpose row vector input variables
    n = cols;
    for v = 1:nvar
      data{v} = data{v}.';
    end
  else
    n = rows;
  end
  % Evaluate bootfun
  if ~strcmp(class(bootfun),'function_handle')
    error('bootfun must be a function name or function handle');
  end
  try
    T0 = feval(bootfun,data{:});
  catch
    error('An error occurred while trying to evaluate bootfun with the input data');
  end
  if max(size(T0))>1
    error('Column vector inputs to bootfun must return a scalar');
  end
  for v = 1:nvar
    x = data{v};
    % Minimal simulation to evaluate bootfun with matrix input arguments
    if v == 1
      simidx = 1+fix(rand(n,2)*n);
    end
    M{v} = x(simidx);
  end
  try
    sim = feval(bootfun,M{:});
    if size(sim,1)>1
      error('Invoke catch statement');
    end
  catch
    warning('ibootci:slowMode',...
            'Slow mode. Faster if matrix input arguments to bootfun return a row vector.')
    mode = 'slow';
  end
  % Set the bootstrap sample sizes
  if iter==0
    B = 2000;
    C = 200;
  elseif iter==1
    B = nboot;
    C = 0;
  elseif iter==2
    B = nboot(1);
    C = nboot(2);
  end
  % Convert alpha to nominal coverage level (decimal format)
  alpha = 1-alpha;
  % NONPARAMETRIC BOOTSTRAP
  % Generate matrix of indices for the first bootstrap if not provided in
  % bootsam
  if isempty(idx)
    idx = 1+fix(rand(n,B)*n);
  end
  if strcmp(mode,'fast')
    % Calculate statistics for the first bootstrap samples (fast mode)
    for v = 1:nvar
      X1{v} = data{v}(idx);
    end
    T1 = feval(bootfun,X1{:});
    % Perform second bootstrap in fast (vectorized) mode
    if ~isempty(C) && C>0
      % Preallocate variables
      T2 = zeros(C,B);
      % Prepare bootstrap for linear indexing
      j = 1:n:B*n;
      J = ones(n,1)*j;
      for c = 1:C
        % Use linear indexing to vectorize bootstrap sampling from X1
        idX1 = J+fix(rand(n,B)*n);
        for v = 1:nvar
          X2{v} = X1{v}(idX1);
        end
        T2 (c,:) = feval(bootfun,X2{:});
      end
      U = sum(T2<=T0,1)/C;
    end
  elseif strcmp(mode,'slow')
    % Preallocate variables
    T1 = zeros(1,B);
    x1 = cell(1,nvar);
    U = zeros(1,B);
    % Calculate statistics for the first bootstrap samples (slow mode)
    for b = 1:B
      for v = 1:nvar
        x1{v} = data{v}(idx(:,b));
      end
      T1(1,b) = feval(bootfun,x1{:});
      % Perform second bootstrap in slow (loop) mode
      if ~isempty(C) && C>0
        % Preallocate variables
        x2 = cell(1,nvar);
        T2 = zeros(C,1);
        % Bootstrap sampling from x1
        for c = 1:C
          idx1 = 1+fix(rand(n,1)*n);
          for v = 1:nvar
            x2{v} = x1{v}(idx1);
          end
          T2(c,1) = feval(bootfun,x2{:});
        end
        U(b) = sum(T2<=T0,1)/C;
      end
    end
  end
  bootstat = T1(:);
  % Calibrate nominal coverage level to achieve desired coverage probability
  if ~isempty(C) && C>0
    k = fix((B+1)*alpha);
    V = sort(abs(2*U-1),2);
    alpha = V(k);
  end
  % Construct confidence interval
  m1 = fix(0.5*(B+1)*(1+alpha));
  m2 = fix(0.5*(B+1)*(1-alpha));
  T1 = sort(T1);
  if alpha<1
    LL = T1(m2);
    UL = T1(m1);
  elseif alpha==1
    warning('ibootci:calibrationHitEnd',...
            'Calibrated coverage hit the ends of the bootstrap distribution.');
    LL = T1(m2+1);
    UL = T1(m1-1);
  end
  ci = [LL;UL];
  % Convert calibrated nominal coverage back to alpha (decimal format)
  alpha = 1-alpha;

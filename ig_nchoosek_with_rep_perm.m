function p = ig_nchoosek_with_rep_perm(values, k)
%IG_NCHOOSEK_WITH_REP_PERM			- all possible permutations of k from n values, with repetition, order is important
% partially derived from:
% https://stackoverflow.com/questions/28284671/generating-all-combinations-with-repetition-using-matlab
% 
% Notes: (see also https://se.mathworks.com/matlabcentral/fileexchange/7147-permn-v-n-k)
% If the order doesn't matter, it is a Combination.
% If the order does matter it is a Permutation.
%
% http://en.wikipedia.org/wiki/Permutation% 
% http://en.wikipedia.org/wiki/Combination
% http://mathworld.wolfram.com/Combination.html
% https://www.mathsisfun.com/combinatorics/combinations-permutations.html


if numel(values)==1 
    n = values;
    combs = nchoosek(n+k-1,k);
else
    n = numel(values);
    combs = bsxfun(@minus, nchoosek(1:n+k-1,k), 0:k-1);
    combs = reshape(values(combs),[],k);
end

% More memory-intensive alternative
% combs = unique(sort(nchoosek(repmat(values,1,k),k),2),'rows')

p=zeros(0,k);
for i=1:size(combs,1),
    pi = perms(combs(i,:));
    p = unique([p; pi],'rows');
end

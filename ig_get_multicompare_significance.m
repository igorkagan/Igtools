function ch = ig_get_multicompare_significance(c)
%IG_GET_MULTICOMPARE_SIGNIFICANCE		- get multicompare significance
% take c output from multicompare and return which pairwise comparisons are significant (1) and not (0)

for k = 1:size(c,1),
	ch(k) = (c(k,4) > 0 && c(k,3) > 0) || (c(k,4) < 0 && c(k,5) < 0);	
end

ch = ch';
function [z, p] = ig_two_proportion_ztest(c1, n1, c2, n2)
    % Two-proportion z-test with p-value
    p1 = c1 / n1;
    p2 = c2 / n2;
    p_pooled = (c1 + c2) / (n1 + n2);
    se = sqrt(p_pooled * (1 - p_pooled) * (1/n1 + 1/n2));
    z = (p1 - p2) / se;

    % Compute two-tailed p-value
    p = 2 * (1 - normcdf(abs(z))); % normcdf is the standard normal CDF
end
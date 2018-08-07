function y = ig_probit(p)
%IG_PROBIT		- probit function
% https://en.wikipedia.org/wiki/Probit

y = sqrt(2)*erfinv(2*p-1);

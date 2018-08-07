function seq = ig_condition_probability_to_sequence(conditions,prob,n_reps)
%IG_CONDITION_PROBABILITY_TO_SEQUENCE		- condition probability to sequence
% seq = ig_condition_probability_to_sequence([1 2 3 4 5],[0 0 0.2 0.3 0.5],100)

freq = round(prob*n_reps);

seq = zeros(1,n_reps); % pre-allocate the vector
n = 0;
for c = 1:length(conditions)
	if freq(c) > 0,
		seq(n+1:n+freq(c)) = conditions(c);
		n = n + freq(c);
	end
end

% seq = randsample(conditions,n_reps,true,freq); % this approach only works approximately
% tabulate(seq);
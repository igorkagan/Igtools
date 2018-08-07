function [y,f] = ig_spectrum(s)
%IG_SPECTRUM		- spectrum

Fs = 1000;
n_trials = size(s,3);

for trial_c = 1:n_trials,
        s_c = s(:,1,trial_c)';
        [yy(:,trial_c),f] = psd(s_c,1024,Fs,[]);   
end

y = mean(yy,2);
                                        

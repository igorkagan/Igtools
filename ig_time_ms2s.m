function time_s = ig_time_ms2s(time_ms)
%IG_TIME_MS2S		- time ms2s (not really working?)
% the aim was to avoid precision errors when dividing ms / 1000 to get s ...
% but not working...

time_ms_1	= time_ms(1)/1000;
time_ms_end	= time_ms(end)/1000;

time_s = linspace(time_ms_1,time_ms_end,length(time_ms));





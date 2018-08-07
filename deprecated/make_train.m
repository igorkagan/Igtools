function spike_train = make_train(spike_arrival_times, start_time, end_time);
mfile_name = mfilename; disp_ig_warning(mfile_name);
% make_train	-  spike arrival times vector to spike train vector (0,1)
% assumes sampling rate 1kHz (ms precision)
%--------------------------------------------------------------------------------
% Input(s): 	spike_arrival_times (ms)
%		start_time (ms) [optional, default - first spike]
% 		end_time (ms) [optional, default - last spike]
% Output(s):	spike_train
% Usage:	spike_train = make_train(spike_arrival_times, 0, 1000);
%
% Last modified 08.06.04
%--------------------------------------------------------------------------------

if nargin<2,
	start_time = min(spike_arrival_times);
end
if nargin<3,
	end_time = max(spike_arrival_times);
end

spike_train = zeros(1,end_time-start_time);
spike_train(ceil(spike_arrival_times-start_time+eps)) = ones(size(spike_arrival_times));



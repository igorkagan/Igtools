function out = ig_running_average(in,ws)
%IG_RUNNING_AVERAGE		- running average
% ws - window size, or actual smoothing window profile

if length(ws) == 1,
	ws = ones(1,ws)/ws;
else
	sws = sum(ws);
	ws = ws/sws;
end

ws_half		= fix(length(ws)/2);

lpad = ones(1,ws_half)*mean(in(1:ws_half));
rpad = ones(1,ws_half)*mean(in(end-ws_half:end));

in = in(:)'; in = [lpad in rpad]; 
% out = filter(ws,1,in);
% out = out(ws_half+1:end-ws_half);

out = conv(in,ws,'same');
out = out(ws_half+1:end-ws_half);


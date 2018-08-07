function out = ig_std(in,DIM)
%IG_STD		- std NaN or MATLAB, DIM correct
% here is a complication: std by MATLAB needs second input as N to normalize by..., and third - DIM
% but if we supersede std by std from NaN toolbox (not by MATLAB), then DIM should be second input...

if nargin < 2,
        DIM = 1;
end

a = which('std');

if ~isempty(findstr(lower(a),'nan')),
        out = std(in,DIM);      
else % MATLAB DEFAULT
        out = std(in,1,DIM);
end
function y = clean_convolve (x,kern)
mfile_name = mfilename; disp_ig_warning(mfile_name);
x = x(:)'; % make row
nf = length(kern);

if ~mod(nf,2) % even length of kernel
	npad = (nf)/2;
else % odd 
	npad = (nf - 1)/2;
end

lpad = ones(1,npad)*mean(x(1:npad));
rpad = ones(1,npad)*mean(x(end-npad:end));

padx = [lpad x rpad];

y = convn(padx, kern, 'same');
y = y(npad+1:end-npad);

if length(x) ~= length(y)
        error('convolution gone bad...');
end

% previous version - worked only with odd-length kernel

% x = x(:)'; % make row
% nf = length(kern);
% 
% npad = (nf - 1)/2;
% 
% 
% lpad = ones(1,npad)*mean(x(1:npad));
% rpad = ones(1,npad)*mean(x((npad+1:end):end));
% 
% padx = [lpad x rpad];
% 
% y = convn(padx, filt, 'valid');
% 
% if length(x) ~= length(y)
%         error('convolution gone bad...');
% end

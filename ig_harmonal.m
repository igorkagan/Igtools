function [f,y,fh,h] = ig_harmonal(s, Fs, F1)
%IG_HARMONAL		- harmonic analysis of 1D signal, e.g. spike train
%--------------------------------------------------------------------------------
% Input(s): 	s 	- input signal
%		Fs 	- sampling frequency of signal (Hz)
%		F1	- fundamental frequency (Hz) [optional]	
% Output(s):	f	- frequency axis (Hz)
%		y 	- power spectrum
%		fh	- vector of harmonic frequencies
%		h	- harmonics (F0, F1, etc...)
% Usage:	Fs=1000; t=0:1/(Fs-1):1; s=sin(2*pi*5*t);
%		[f,y,fh,h] = ig_harmonal(s, Fs, 5);
%
% Last modified 24.06.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

y=fft(s);
y = y(1:ceil((length(y)-1)/2));
y = y*2;
y(1)=y(1)/2;
y=y/length(s);
n = length(y);
f = (0:n-1)*(Fs)/(2*n);
y = abs(y);

if nargin < 3,
	h = [];
	fh = [];
else
	fF1 = f(find((f-F1)==min(abs(f-F1))));
	h = y(1:fF1:length(y));
	fh = f(1:fF1:length(f));
end

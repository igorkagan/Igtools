function [rc, channel] = ig_dde2e(topic, range, data)
%IG_DDE2E		- DDE to Excel
%--------------------------------------------------------------------------------
% Input(s): 	topic 	- DDE topic
%		range 	- cell range
%		data 	- data
% Output(s):	rc	- return code: 0 indicates failure, 1 indicates success.	
%		channel	- conversation channel from DDEINIT.
% Usage:	[rc, channel] = ig_dde2e('sheet1', range, data);
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

% Initiates conversation
channel = ddeinit('Excel',topic);

% Send data to Excel
rc      = ddepoke(channel, range, data); 



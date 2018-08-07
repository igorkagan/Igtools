function vec = ig_vector_to_consecutive_integers(vec,start_value,exclude_value)
%IG_VECTOR_TO_CONSECUTIVE_INTEGERS		- converts an arbitrary vector to vector of consecutive integers, starting from start_value
%
% USAGE:
% vec = [2 8 3 4 3 3 3 2 8]; ig_vector_to_consecutive_integers(vec,10);
% vec = [2 8 3 4 3 0 3 3 2 NaN 8]; ig_vector_to_consecutive_integers(vec,10); % exclude 0
%
% INPUTS:
%		vec		- vector
%		start_value	- start value (default 1)
%		exclude_value   - exclude value that will not be converted (default [])
%
% OUTPUTS:
%		vec		- vector of consecutive integers, starting from start_value

% REQUIRES:	none
%
% See also IG_ANALYZE_TRIAL_SEQUENCE
%
%
% Author(s):	I.Kagan, DAG, DPZ
% URL:		http://www.dpz.eu/dag
%
% Change log:
% 20180723:	Created function (Igor Kagan)
% ...
% $Revision: 1.0 $  $Date: 2018-07-23 13:25:32 $
%%%%%%%%%%%%%%%%%%%%%%%%%[DAG mfile header version 1]%%%%%%%%%%%%%%%%%%%%%%%%% 

if nargin < 2,
	start_value = 1;
end

if nargin < 3,
	exclude_value = [];
end


entries = unique(vec(vec~=exclude_value)); % sorted unique entries in vector

% brute force method (not too elegant)
for k = 1:length(entries),
	vec(vec==entries(k))=start_value+k-1;
end

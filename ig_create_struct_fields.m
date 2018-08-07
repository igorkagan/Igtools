function out = ig_create_struct_fields(varargin)
%IG_CREATE_STRUCT_FIELDS		- create struct fields
% Example: var1 = 1; var2 = 'text'; out = ig_create_struct_fields(var1,var2); % will create struct out with fields var1 and var2

for k = 1:nargin,
       out.(inputname(k)) = varargin{k};
end



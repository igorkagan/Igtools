function s = ig_assign_struct_fields(s,varargin)
%IG_ASSIGN_STRUCT_FIELDS		- assign struct fields

if ischar(s), % empty struct
        s = struct;
end

for k = 1:nargin-1,
        s.(inputname(k+1)) = varargin{k};
        
end

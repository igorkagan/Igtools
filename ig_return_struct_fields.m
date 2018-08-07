function varargout = ig_return_struct_fields(s,varargin)
%IG_RETURN_STRUCT_FIELDS		- return struct fields
        
if nargin == 1, % return all fields
        struct_fieldnames = fieldnames(s);
        n_fields =length(fieldnames(s));

        if nargout ~= n_fields
                warning('Number of outputs (%d) does not match number of structure fields (%d)',nargout,n_fields);
        end

        for k = 1:nargout
              varargout(k) = {s.(struct_fieldnames{k})};
        end

else % specific fields

        for k = 1:nargin-1,
                varargout(k) = {s.(varargin{k})};

        end
end
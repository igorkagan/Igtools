function str = ig_struct2string(s,fnames)
%IG_STRUCT2STRING		- struct2string

% see http://stackoverflow.com/questions/18204535/write-field-name-and-value-form-structures-to-a-file	
	
fields = fieldnames(s);
values = struct2cell(s);

if nargin > 1,
	[c, idx2take] = intersect(fields,fnames);
	fields = fields(idx2take);
	values = values(idx2take);
end
	

% Convert numerical values to strings
idx = cellfun(@isnumeric, values); 
values(idx) = cellfun(@num2str, values(idx), 'UniformOutput', false);

% Convert cell arrays of strings to comma-delimited strings
idx = cellfun(@iscellstr, values);
stringify_cellstr = @(x){['{' sprintf('''%s'', ', x{1:end - 1}) ...
   sprintf('''%s''', x{end}) '}']};
values(idx) = cellfun(stringify_cellstr, values(idx));

% Convert cell array of numbers to strings
idx = cellfun(@iscell, values);
isnumber = @(x)isnumeric(x) && isscalar(x);
idx_num = cellfun(@(x)all(arrayfun(@(k)isnumber(x{k}),1:numel(x))), values(idx));
idx(idx) = idx_num;
stringify_cellnum = @(x){['{' sprintf('%d, ',x{1:end - 1}) num2str(x{end}) '}']};
values(idx) = cellfun(stringify_cellnum, values(idx));

% Combine field names and values in the same array
C = {fields{:}; values{:}};

%// Write fields to text file

str = sprintf(repmat('%s:%s ', 1, size(C, 2)), C{:});
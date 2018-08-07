function out = ig_replace_string_in_all_struct_fields (s,search_str,replacement_str)
%IG_REPLACE_STRING_IN_ALL_STRUCT_FIELDS		- replace string in all struct fields
% searches through a structure "s" with any hierarchy recursively, and replaces all instances of
% "search_str" with "replacement_str" in string fields

if isstruct(s),
	fnames = fieldnames(s);
	for k = 1:length(fnames),
		out1 = ig_replace_string_in_all_struct_fields(s.(fnames{k}),search_str,replacement_str);
		out.(fnames{k}) = out1;
	end
	
else	
	out = regexprep(s,search_str,replacement_str);
end






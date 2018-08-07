function [isequal different_fields different_fields_values1 different_fields_values2] = ig_struct_compare(s1,s2)
%IG_STRUCT_COMPARE		- compares two struct and returns several outputs
% isequal - 0/1
% different_fields
% different_fields_values

fnames1 = fieldnames(s1);
fnames2 = fieldnames(s2);
different_fields = setdiff(fnames1,fnames2);
different_fields_values1 = {};
different_fields_values2 = {};

if length(fnames1) ~= length(fnames2),
	isequal = 0;	
elseif ~isempty(different_fields),
	isequal = 0;
else % equal fieldnames, check values
	
	different_fields = {};
	isequal = 1;
	
	for k=1:length(fnames1),
		if isstruct(s1.(fnames1{k})),
			[isequal different_fields_k different_fields_values1_k different_fields_values2_k] = ig_struct_compare(s1.(fnames1{k}),s2.(fnames2{k}));
			if ~isequal,
				different_fields = [different_fields different_fields_k];
				different_fields_values1 = [different_fields_values1 different_fields_values1_k];
				different_fields_values2 = [different_fields_values2 different_fields_values2_k];
			end
		else
			
			if ~all(s1.(fnames1{k})== s2.(fnames2{k})),
				isequal = 0;
				different_fields = [different_fields fnames1{k}];
				different_fields_values1 = [different_fields_values1 s1.(fnames1{k})];
				different_fields_values2 = [different_fields_values2 s2.(fnames2{k})];
			end
		end
	end
end
		







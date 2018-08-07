function out = ig_insert_values_into_vector(vector,indices,values)
%IG_INSERT_VALUES_INTO_VECTOR		- insert values into vector

if length(indices) > length(values)
	if length(values) == 1, % insert same values into indices
		values = values*ones(size(indices));
	else
		error(sprintf('%d indices do not match %d values',length(indices),length(values)));
	end
end

c=false(1,length(vector)+length(indices));
c(indices)=true;
out=nan(size(c));
out(~c)=vector;
for k = 1:length(values),
	out(indices(k))=values(k);
end
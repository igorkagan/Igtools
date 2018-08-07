function [status,message] = ig_movefile(source,destination,verbose)
%IG_MOVEFILE		- movefile using java
if nargin < 3,
	verbose = 0;
end

status = java.io.File(source).renameTo(java.io.File(destination));


if status
	message = [source ' -> ' destination ' successful'];

else
	message = [source ' -> ' destination ' not successful'];

end

if verbose, disp(message); end

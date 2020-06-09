function [status,message] = ig_copyfile(source,destination,verbose)
%IG_COPYFILE		- copyfile using java, NOT WORKING YET!
if nargin < 3,
	verbose = 0;
end

% NOT WORKING YET!
jFile_source = java.io.File(source); % java.nio.file.Paths.get('C:\', javaArray('java.lang.String', 0))
jFile_destination = java.io.File(destination);
status = java.nio.file.Files.copy(jFile_source,jFile_destination);


if status
	message = [source ' -> ' destination ' successful'];

else
	message = [source ' -> ' destination ' not successful'];

end

if verbose, disp(message); end

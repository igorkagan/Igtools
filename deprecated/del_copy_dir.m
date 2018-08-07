function del_copy_dir(fromdir,todir,avoid,verbose)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% delete all files in "fromdir" directory except avoid, which is copied to directory "todir
%--------------------------------------------------------------------------------


if nargin < 3,
	avoid = '';
end

if nargin < 4,
	verbose = 0;
end


% first move "avoid"

[success,message] = movefile([fromdir filesep avoid],[todir filesep avoid]);
if ~success,
        disp(message);
        return;
end

% now delete "fromdir"


[success,message] = rmdir(fromdir,'s');	

if ~success,
        disp(message);
        return;
end

function ig_del_copy_dir(fromdir,todir,avoid)
%IG_DEL_COPY_DIR		- delete all files in "fromdir" directory except avoid, which is copied to directory "todir
%--------------------------------------------------------------------------------


if nargin < 3,
	avoid = '';
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
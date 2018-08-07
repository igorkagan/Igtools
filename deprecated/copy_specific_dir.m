function copy_specific_dir(fromdir,todir,specific_dir,move,verbose)
mfile_name = mfilename; disp_ig_warning(mfile_name);
% copy specific_dir in directory "fromdir" to directory "todir"
% copy_specific_dir('/data1/MRI/Florian/20100125','/mnt/hylobates/MRI/Florian/20100125','im',1);


if nargin < 4,
    move = 0;
end

if nargin < 5,
	verbose = 0;
end


if ~(exist(todir)==7),
	todir_lastslash_idx = findstr(todir,filesep);
	if isempty(todir_lastslash_idx),
		parent_todir = '.';
		new_todir = todir;
	else
		parent_todir = todir(1:todir_lastslash_idx(end));
		new_todir = todir(todir_lastslash_idx(end)+1:end);
	end
	[success,message] = mkdir(parent_todir,new_todir);
	if ~success,
		disp(message);
		return;
	end
end

ini_dir = pwd;
cd(fromdir);


tic;
if move
    movefile(specific_dir,[todir filesep specific_dir]);
else
    copyfile(specific_dir,[todir filesep specific_dir]);
end
if verbose,
        t = toc;
        disp([specific_dir ' copied in ' num2str(t) ' seconds']);
end

disp(['< ' specific_dir,' directory copied from ', fromdir,' to ' todir ' >']);

cd(ini_dir);
	


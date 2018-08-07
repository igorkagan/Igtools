function ig_copy_dir(fromdir,todir,do_not_ig_copy_dirs,avoid,verbose)
%IG_COPY_DIR		- copy all files in directory "fromdir" to directory "todir" except avoid
% ig_copy_dir('Z:\MRI\Curius\20141017','Y:\MRI\Curius\20141017',1,'.zip')


if nargin < 3,
	do_not_ig_copy_dirs = 0;
end

if nargin < 4,
	avoid = '';
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

% get current dir listing
d = dir;

n = 0;
for i=3:size(d,1),
	
	if ~(d(i).isdir && do_not_ig_copy_dirs) && isempty(strfind(d(i).name,avoid)),
		tic;
		copyfile(d(i).name,[todir filesep d(i).name]);
		n = n + 1;
		if verbose,
			t = toc;
			disp([d(i).name ' copied in ' num2str(t) ' seconds']);
		end
	end
	
end

disp(['<Total ' num2str(n),' directories and files copied from ', fromdir,' to ' todir '>'])
	


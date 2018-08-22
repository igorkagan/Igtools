function ig_copy_file_list_to_dir(fromdir,todir,filelist,exact_names,additional_pattern,remove_original,verbose)
%IG_COPY_FILE_LIST_TO_DIR		- copy or move files in filelist from fromdir to todir
% e.g. ig_copy_file_list_to_dir('Y:\Projects\Pulv_oculomotor\ephys\20180222\single_cell_examples','C:\Temp','C:\Temp\cells_perisac_ehn_42.txt',0,'memory',0,1);

if nargin < 4,
	exact_names = 1;
end

if nargin < 5,
	additional_pattern = '';
end

if nargin < 6,
	remove_original = 0;
end

if nargin < 7,
	verbose = 0;
end

if ischar(filelist), % filelist file
	fid=fopen(filelist,'rt');
	k = 1;
	n_files_in_list = 0;
	while 1
		name = fgetl(fid);
		n_files_in_list = n_files_in_list + 1;
		
		if ~ischar(name), break, end
		
		if exact_names, 
			list{k} = [fromdir filesep name];
			k = k + 1;
		else % each entry in list is a pattern to search for
			if strfind(name,'*'),
				pattern = name;
			else
				pattern = ['*' name '*' additional_pattern '*'];
			end
			[d] = dir([fromdir filesep pattern]);
			n = length(d);
			if n>0,
				list(k:k+n-1) = {d.name};
				k = k + n;
			end
			if verbose,
				fprintf('Processing list entry %d, found %d files corresponding to pattern %s\n',n_files_in_list,n,pattern);
			end
			
		end
		
		
	end
	k = k - 1;
	fclose(fid);	
end

if ~isdir(todir),
	[success,message] = mkdir(todir);
	if ~success,
		disp(message);
		return;
	end
end

for f=1:k,
	if remove_original,
		[success,message] = movefile([fromdir filesep list{f}],todir);
	else
		[success,message] = copyfile([fromdir filesep list{f}],todir);
	end
	if ~success,
		disp(message);
		return;
	end
end

if success,
	fprintf('Copied %d files from %s to %s\n',k,fromdir,todir);
end
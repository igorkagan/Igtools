function ig_add_filename_prefix(FromPattern,prefix,change_function_name_prefix,TargetDir)
%IG_ADD_FILENAME_PREFIX		- add filename prefix
% ig_add_filename_prefix('*.m','ig_',1,'C:\Temp');

if nargin ==4,
	cd(TargetDir);
end

d = dir(['*' FromPattern '*']);
for k=1:length(d),
	newname =   [prefix d(k).name];
	movefile(d(k).name,newname);
	
	if change_function_name_prefix % in case those are matlab functions
		fid = fopen(newname,'rt');
		s = fread(fid);
		fclose(fid);
		
		fid = fopen(newname,'wt');
		new_s = strrep(s,d(k).name(1:end-2),newname(1:end-2)); % exclude .m
		fwrite(fid,new_s);
		fclose(fid);
	end
end

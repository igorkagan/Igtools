function ig_rename_files(FromPattern,ToPattern,TargetDir)
%IG_RENAME_FILES		- rename files

if nargin ==3,
	
	cd(TargetDir);
end

if isunix
	eval(['!mv *' FromPattern '* *'  ToPattern '*']);
	
else
	d = dir(['*' FromPattern '*']);
	for k=1:length(d),
		newname =   regexprep(d(k).name,FromPattern,ToPattern);
		movefile(d(k).name,newname);
	end
end
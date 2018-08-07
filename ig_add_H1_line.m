function ig_add_H1_line(FromPattern,TargetDir)
%IG_ADD_H1_LINE		- add h1 line

if nargin == 2,
	cd(TargetDir);
end

d = dir(['*' FromPattern '*']);
for k=1:length(d),
	
	fid = fopen(d(k).name,'rt');
	line1 = fgetl(fid);
	line2 = fgetl(fid);
	fclose(fid);
	fname = d(k).name(1:end-2); % remove .m
	
	if ~strncmp(line2,['%' upper(fname)],length(fname)+1), % no proper H1 line, add one
		fid = fopen(d(k).name,'rt');
		s = fread(fid);
		fclose(fid);
		
		H1_description = strrep(fname,'ig_',''); % add some automatic description made from filename
		H1_description = lower(strrep(H1_description,'_',' '));
		
		new_s = strrep( char(s)', line1, [ line1 sprintf('\n') '%' upper(fname) sprintf('\t\t- ')  H1_description] );
		
		fid = fopen(d(k).name,'wt');
		fwrite(fid,new_s);
		fclose(fid);
	end
	
end

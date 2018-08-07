function make_content
mfile_name = mfilename; disp_ig_warning(mfile_name);
% make_content 	- creates or updates the contents.m file in the current directory
%--------------------------------------------------------------------------------
% Input(s): 	none
% Output(s):	none
% Usage:	make_content
%
% Last modified 17.08.02
% Copyright (c) 2002 Igor Kagan					 
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

if ~exist([pwd '\contents.m']) % contents.m does not exist
	header_line1 = ['% <Add description here>'];
	header_line2 = ['% Version <...>  Revision <...>'];
	header_line3 = ['% Copyright 2002 Igor Kagan, http://igoresha.virtualave.net'];

else  
    	fid=fopen('contents.m','rt');
    	header_line1=fgetl(fid);
	header_line2=fgetl(fid); 
	header_line3=fgetl(fid);
    	fclose(fid);
    	delete contents.m
end

files = what;  % Structure with fields files.m, files.mat, etc.

if length(files.m)==0
   	warning(['No m-files found in directory ' pwd])
    	return  
end

fcontents = fopen('contents.m','wt');

% Write header
fprintf(fcontents,'%s\n',header_line1);    
fprintf(fcontents,'%s\n',header_line2);
fprintf(fcontents,'%s\n',header_line3);
fprintf(fcontents,'%s\n',['% $ Created on ' datestr(now) ' $']);
fprintf(fcontents,'%s\n','%  ');

% Make all filenames lowercase
files.m = sort(lower(files.m));

% Write H1 lines to contents.m
for i = 1:length(files.m)
    	fid=fopen(files.m{i},'rt');
    	H1found = 0;
    	while ~H1found & feof(fid)==0; 
       		linestr = fgetl(fid);
        	if length(linestr) > 0
            		if ~isempty(findstr(linestr,'%'))
                		H1found = 1;
                		fprintf(fcontents,'%s\n',linestr); % Write H1 line to contents.m
            		end
        	end
        	if feof(fid)==1 % No H1 line found
            		fprintf(fcontents,'%s\n','% 	- [no H1 line specified]');
        	end
    	end
    	fclose(fid);
end
disp('file contents.m was created/updated');
fclose(fcontents);


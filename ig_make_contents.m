function ig_make_contents
%IG_MAKE_CONTENTS		- creates or updates the Contents.m file in the current directory
%--------------------------------------------------------------------------------
% Input(s): 	none
% Output(s):	none
% Usage:	ig_make_contents
%
% Last modified 20180806
% Igor Kagan					 
%--------------------------------------------------------------------------------

if ~exist([pwd filesep 'Contents.m'],'file') % contents.m does not exist
	header_line1 = ['% <Add description here>'];
	header_line2 = ['% Version <xxx> dd-mmm-yyyy']; % Version xxx dd-mmm-yyyy
	header_line3 = ['% Copyright 2002-2018 Igor Kagan, http://igorkagan.org'];

else  
    	fid=fopen('Contents.m','rt');
    	header_line1=fgetl(fid);
	header_line2=fgetl(fid); 
	header_line3=fgetl(fid);
    	fclose(fid);
    	delete Contents.m
	disp('Found previous Contents.m, deleting');
end

files = what;  % Structure with fields files.m, files.mat, etc.

if isempty(files.m)
   	warning(['No m-files found in directory ' pwd]);
    	return;
end

fcontents = fopen('Contents.m','wt');

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
    	while ~H1found &&  feof(fid)==0; 
       		linestr = fgetl(fid);
        	if ~isempty(linestr)
            		if strncmpi(linestr,'%',1)
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
disp('file Contents.m was created/updated');
fclose(fcontents);


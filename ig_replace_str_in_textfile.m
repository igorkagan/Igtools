function ig_replace_str_in_textfile(fname, searchstr, replacestr)
%IG_REPLACE_STR_IN_TEXTFILE		- replace str in textfile

fid = fopen(fname,'rt');
s = fread(fid);
fclose(fid);

fid = fopen(fname,'wt');
new_s = strrep(s,searchstr,replacestr);
fwrite(fid,new_s);
fclose(fid);
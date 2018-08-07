function replace_str_in_textfile(fname, searchstr, replacestr)
mfile_name = mfilename; disp_ig_warning(mfile_name);

fid = fopen(fname,'rt');
s = fread(fid);
fclose(fid);

fid = fopen(fname,'wt');
new_s = strrep(s,searchstr,replacestr);
fwrite(fid,new_s);
fclose(fid);

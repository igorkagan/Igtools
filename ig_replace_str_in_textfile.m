function ig_replace_str_in_textfile(fname, searchstr, replacestr, excludestr)
%IG_REPLACE_STR_IN_TEXTFILE		- replace str in textfile

if nargin < 4,
    excludestr = '';
end


fid = fopen(fname,'rt');
s = fread(fid);
fclose(fid);

fid = fopen(fname,'wt');

if isempty(excludestr),
    new_s = strrep(s,searchstr,replacestr);
else
    % replace but omit instances of excludestr
    new_s = strrep(s,excludestr,'excludestr');
    new_s = strrep(new_s,searchstr,replacestr);
    new_s = strrep(new_s,'excludestr',excludestr);
end
    
fwrite(fid,new_s);
fclose(fid);
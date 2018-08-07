function orient_all(options)
mfile_name = mfilename; disp_ig_warning(mfile_name);

hWin = sort(get(0,'Children'));
for i=1:length(hWin);
    	orient(hWin(i),options);
end

function ig_orient_all(options)
%IG_ORIENT_ALL		- orient all
% see orient for options

hWin = sort(get(0,'Children'));
for i=1:length(hWin);
    	orient(hWin(i),options);
end

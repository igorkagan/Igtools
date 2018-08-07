% get_excel_columns
mfile_name = mfilename; disp_ig_warning(mfile_name);
%------------------------------------------------------------------------
% SET THIS:
N 	= 203; 		% total number of cells
Topic 	= 'Sheet3';	% excel sheet name
offset 	= 0;		% column offset 

channel = ddeinit('Excel',Topic);
format = [1 1];

for i=1:N	
	t(i).cellname1	=	 (ddereq(channel, ['r',num2str(i+1),'c1:r',num2str(i+1),'c1'],format));
	t(i).cellname1 = t(i).cellname1(1:end-1);
	t(i).cellname2	=	 (ddereq(channel, ['r',num2str(i+1),'c2:r',num2str(i+1),'c2'],format));
	t(i).cellname2 = t(i).cellname2(1:end-1);
end
rc = ddeterm(channel);

[cellname1{1:N}] = deal(t.cellname1);
[cellname2{1:N}] = deal(t.cellname2);


for i=1:N	
	t = find(strcmp(cellname2,cellname1(i)));
	if ~isempty(t),
		ind(i) = t;
	else
		ind(i) = 0;
	end
end


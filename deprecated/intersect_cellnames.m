function [shared_cellnames, i1, i2, cellname1, cellname2] = intersect_cellnames;
mfile_name = mfilename; disp_ig_warning(mfile_name);
% intersect_cellnames	- find intersection between two columns of cellnames
%--------------------------------------------------------------------------------
% Input(s): 	None (set parameters in SET THIS section below)
% Output(s):	shared_cellnames
%		i1 - indeces of shared cells in set 1
%		i2 - indeces of shared cells in set 2
% 		cellname1
%		cellname2
% Usage:	[shared_cellnames, i1, i2] = intersect_cellnames;
%
% Last modified 17.10.04
%--------------------------------------------------------------------------------

% SET THIS:
N 	= 250; 		% total number of cells in set1 (cellname1) ! LARGER SET !
n 	= 43; 		% total number of cells in set2 (cellname2)
Topic 	= '43 cells blank';	% excel sheet name
offset 	= 0;		% column offset 
IGNORE_CASE = 1;

% END OF SET THIS

channel = ddeinit('Excel',Topic);
format = [1 1];

for i=1:N	
	t1(i).cellname1	=	 (ddereq(channel, ['r',num2str(i+1),'c1:r',num2str(i+1),'c1'],format));
	t1(i).cellname1 = t1(i).cellname1(1:end-1);
	if i<=n,
		t1(i).cellname2	=	 (ddereq(channel, ['r',num2str(i+1),'c2:r',num2str(i+1),'c2'],format));
		t1(i).cellname2 = t1(i).cellname2(1:end-1);
	else
		t1(i).cellname2 = 'dummy';
	end
end
rc = ddeterm(channel);

[cellname1{1:N}] = deal(t1.cellname1);
[cellname2{1:N}] = deal(t1.cellname2);

% short implementation - sux, since result is sorted ...
% [shared_cellnames, i1, i2] = intersect(cellname1,cellname2);
% i1 - indeces of shared cells in set 1
% i2 - indeces of shared cells in set 2

% long implementation

M = NaN*ones(1,N);

i1 = [];
i2 = [];

for i=1:N
	if IGNORE_CASE
        	idx = find(strcmp(lower(cellname2(i)),lower(cellname1)));
		ii = find(strcmp(lower(cellname1(i)),lower(cellname2)));
	else
		idx = find(strcmp(cellname2(i),cellname1));
		ii = find(strcmp(cellname1(i)),cellname2);
	end
	if ~isempty(idx),
		i1 = [i1 idx];
		i2 = [i2 i];
		disp('1');
	else
		disp('0');	
	end
	if 0 % display occurence of c1 in c2 !!! comment disp above
	if ~isempty(ii),
		disp('1');
	else
		disp('0');
	end
	end
end

% cellname3(ind(find(ind>0)))=cellname2(ind_cellname2); % cellname2 re-ordered to match cellname1
shared_cellnames = cellname1(i1);

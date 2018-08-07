function print_all(options,save2file,add_figname)
mfile_name = mfilename; disp_ig_warning(mfile_name);

% print_all	- print or save to file all MATLAB figures
%--------------------------------------------------------------------------------
% Input(s): 	options	- various options (see 'help print') - optional
% Output(s):	none
% Usage:	print_all('-depsc'); % print to Color Encapsulated PostScript
%
% Last modified 01.10.02
% Copyright (c) 2002 Igor Kagan
% kigor@tx.technion.ac.il
% http://igoresha.virtualave.net
%--------------------------------------------------------------------------------

if nargin < 2,
        save2file = 0;
end

if nargin < 3,
	add_figname = 0;
end

hWin = sort(get(0,'Children'));
for i=1:length(hWin);
        set(0,'CurrentFigure',hWin(i));
	if add_figname,
		ig_figure_name;
	end
	
        if nargin < 1
                print
        elseif save2file == 0,
                print(options);
        else
                n = get(hWin(i),'Name');
                if length(n) > 100,
                        n = num2str(i);
                end
                print(options,['fig_' n '.pdf'])
        end
end

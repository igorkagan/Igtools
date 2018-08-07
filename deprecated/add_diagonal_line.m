function add_diagonal_line
mfile_name = mfilename; disp_ig_warning(mfile_name);

xlim = get(gca,'Xlim');
ylim = get(gca,'ylim');

line([xlim(1) xlim(2)],[ylim(1) ylim(2)],'Color','k','LineStyle',':');

function ig_add_equality_line
%IG_ADD_EQUALITY_LINE		- add equality line

xlim = get(gca,'Xlim');
ylim = get(gca,'ylim');

xy = 1*max( [ abs(min([xlim(1) ylim(1)])) abs(max([xlim(2) ylim(2)])) ] );

line(xy*[-1 1],xy*[-1 1],'Color','k','LineStyle',':');
set(gca,'Xlim',xlim,'Ylim',ylim);

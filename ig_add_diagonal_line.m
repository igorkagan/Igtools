function ig_add_diagonal_line
%IG_ADD_DIAGONAL_LINE		- add diagonal line to current axis 
xlim = get(gca,'Xlim');
ylim = get(gca,'ylim');

line([xlim(1) xlim(2)],[ylim(1) ylim(2)],'Color','k','LineStyle',':');

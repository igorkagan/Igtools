function ig_plot_monkey_weight(filepath)
fid = fopen(filepath);

T = textscan(fid,'%s %s %f %f','delimiter',' ','MultipleDelimsAsOne',1,'HeaderLines',3);

w = T{3}; % weight

N_days = length(w);

Nday = datenum( T{2}, 'dd.mm.yy');
Nday_start = Nday(1);

new_year = [];
new_year_str = {};
for year = 10:20
    ny = datenum(['01.01.' num2str(year)],'dd.mm.yy');
    if ny >= Nday(1) && ny <= Nday(end),
        new_year = [new_year ny];
        new_year_str = [new_year_str; ['01.01.' num2str(year)]];
    end
end

Nday = Nday - Nday_start;

firstDayAfterBreak_idx = [1; find(diff(Nday)>1)+1];
notFirstDayAfterBreak_idx = setdiff(1:N_days,firstDayAfterBreak_idx);


figure;
plot(Nday,w,'k-'); hold on;
plot(Nday,w,'g.'); hold on;
% plot(Nday(firstDayAfterBreak_idx),w(firstDayAfterBreak_idx),'r.'); hold on;
ig_add_multiple_vertical_lines(new_year - Nday_start,'Color',[0.4 0.4 0.4],'LineStyle','--');

runave                          = ig_running_average(w,30);
firstDayAfterBreak_runave       = ig_running_average(w(firstDayAfterBreak_idx),10);
notFirstDayAfterBreak_runave    = ig_running_average(w(notFirstDayAfterBreak_idx),30);

plot(Nday,runave,'b'); hold on;
% plot(Nday(firstDayAfterBreak_idx),firstDayAfterBreak_runave,'r'); hold on;
% plot(Nday(notFirstDayAfterBreak_idx),notFirstDayAfterBreak_runave,'g'); hold on;

set(gca,'XTick',new_year - Nday_start,'XTickLabel',new_year_str);
title(filepath,'Interpreter','none');

fclose(fid);
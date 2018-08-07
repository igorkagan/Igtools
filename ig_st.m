function ig_st
%IG_ST		- "st" on the current plot
waitforbuttonpress;
s = get(gco,'Ydata');
s = detrend(s,0);

t = get(gco,'Xdata')*1000;
dt = t(2)-t(1);
len = length(t);

NyquistFreq = 500/dt; % Hz
Fs = 1000/dt;
MaxFreq = 100; % Hz
YFreqSteps = 10;

len/2*MaxFreq/NyquistFreq

[ss,tt,ff] = st(s,-1,len/2*MaxFreq/NyquistFreq,-1,-1);
% [ss,tt,ff] = st(s,-1,100,-1,-1);
figure;
axFS = 8;
axTimeStep = 1; %s

ff(end)

% 1 st axis
axes('Position',[0.25 0.25 0.7 0.7])
imagesc(abs(ss));
xlabel('Time (s)')
ylabel('Frequency (Hz)')
set(gca,'Ydir','normal')
XTickLabel = get(gca,'XTickLabel');
YTickLabel = get(gca,'YTickLabel');

set(gca,'XTick',[axTimeStep*1000/dt:axTimeStep*1000/dt:length(t)]+1,'XTickLabel',[]);
% set(gca,'XTick',[0:axTimeStep*1000/dt:length(t)],'XTickLabel',[0:axTimeStep*1000/dt:length(t)]*dt/1000);
% set(gca,'YTick',[0:length(ff)/YFreqSteps:length(ff)]+0.5,'YTickLabel',[]);
set(gca,'YTick',[0:length(ff)/(MaxFreq/YFreqSteps):length(ff)]+0.5,'YTickLabel',[]);
% set(gca,'YTick',[0:length(ff)/YFreqSteps:length(ff)],'YTickLabel',[0:MaxFreq/YFreqSteps:MaxFreq]);
% set(gca,'XTick',[str2num(XTickLabel)],'XTickLabel',[str2num(XTickLabel)*dt/1000],'YTick',[0:length(f)/YFreqSteps:length(f)],'YTickLabel',[0:MaxFreq/YFreqSteps:MaxFreq])
% set(gca,'XTick',str2num(XTickLabel),'XTickLabel',str2num(XTickLabel)*dt/1000,'YTickLabel',str2num(YTickLabel)/max(str2num(YTickLabel))*MaxFreq )
set(gca,'FontSize',axFS);
grid on

colorbar
set(gca,'FontSize',axFS);

% time series axis
axes('Position',[0.25 0.05 0.599 0.15])
plot(t/1000,s)
set(gca,'FontSize',axFS,'Xlim',[0 max(t)/1000],'XTick',[0:axTimeStep:max(t)/1000]);
ylabel('spikes/sec')
grid on

% spectrum axis
axes('Position',[0.05 0.25 0.15 0.7])
[f,y,fh,h] = harmonal(s, Fs, 5);
plot(y,f)
set(gca,'FontSize',axFS,'Xdir','reverse','Ylim',[0 MaxFreq],'Ytick',[0:2.5:MaxFreq],'YtickLabel',[0:2.5:MaxFreq]);
set(gca,'YAxisLocation','left')
xlabel('spikes/sec')
grid on

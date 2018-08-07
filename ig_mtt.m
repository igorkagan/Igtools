function [tt,ff,mtt,phase] = ig_mtt(t,s,MaxFreq,period,hbw,baseline)
%IG_MTT		- mtt: uses mtfft from neuran (old version of chronux)

s = squeeze(s);

if size(s,1) == length(t),
        s = s'; % should be [trials,time]
end

if 1 % remove mean
        s = s - mean(s,2)*ones(1,size(s,2));
end

if nargin < 3,
    MaxFreq = 100;
end

if nargin < 4,
    period = 300; % in ms, temporal window for spectrogram computation
end

if nargin < 5,
    hbw = 10; % Hz frequency bandwidth
end

if nargin < 6,
    baseline = 0;
end

center_index = period+1:50:(t(end)*1000-period+1);
center_time = (center_index-1)/1000; % s
work=[];

for m=1:length(center_index)
        tc = center_index(m);
        indbin = (tc-(period/2)):(tc+(period/2-1));
        timebin = (indbin)/1000;
        [J,f,hf,work] = mtfft(s,[0.001:0.001:t(end)],[timebin(1) timebin(end)],hbw,2,-1,1,work); % use neuran package
        findex = find(f>0 & f<MaxFreq);
        LFPSpec(:,:,:,m) = J(:,:,findex); % first column: trs, second column: tapers, third column : frequency
end
ff = f(findex);
% tt = ((1:size(s,2))-1)/1000;
tt = center_time;

mtt = mean(mean(abs(LFPSpec(:,:,:,:)).^1,2),1); %mean across tapers and trials
mtt = 10*log10(squeeze(mtt));

phase = mean(mean(angle(LFPSpec(:,:,:,:)),2),1);
phase = squeeze(phase);

%size(mtt)


if baseline % baseline subtraction
        
    baseline_start = 0.5;
    baseline_end = 1.5;
    baseline_tt_idx = find(tt>baseline_start & tt<baseline_end);
    im_baseline = mean(mtt(:,baseline_tt_idx),2);
    mtt = mtt - repmat(im_baseline,1,size(mtt,2));
    
    if 1 % signal change
            
          mtt = 100*mtt./repmat(im_baseline,1,size(mtt,2));     
    end
    
end % of if baseline subtraction


if 0 % debug
    figure
    imagesc(tt,ff,mtt);
    set(gca,'ydir','normal');
    pause;
end
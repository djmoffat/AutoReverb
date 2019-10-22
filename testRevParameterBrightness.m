close all force
clear; clc
addpath('~/Google Drive/Matlab/myPath/');
addpath('~/Google Drive/Matlab/features/');

%% INIT
fs = 44100;
x = [1; zeros(1.5*fs-1,1)];
% x = rand(1.5*fs-1,1);

%% COMPARE ALL 4 PARAMETERS
iterList = 0:0.01:1;
c = 1;
c_ = 1;
pList = {'predelay';'diffus';'decay';'HFDamp'};
% pList = {'diffus';'decay'};
results = zeros(size(iterList,2),size(pList,1));
h = waitbar(0,'Analysing Reverb Parameters')
for jj = 1:size(pList,1)
    t = stdReverb;
    for ii = 1:size(pList)
        t.(pList{jj}) = rand(1);
    end
    for ii = iterList
        t.(pList{jj}) = ii;
        y = process(t,x);
            y_ = mean(y,2);
            results(c,c_) = specCentroid(y_,fs);
        c = c + 1;
    end
    curValue = jj/(size(pList,1)+1) + iterList(ii)/size(pList,1);
    waitbar(curValue,h);
    c = 1;
    c_ = c_ + 1;
end
close(h)
% PLOT
surf(results)

%%
x = [1; zeros(1.5*fs-1,1)];
% x = rand(1.5*fs-1,1);
diffRange = 0.6:0.01:1;
HFDRange = 0:0.01:1;
c = 1;
c_ = 1;
pList = {'diffus';'HFDamp'};
t = stdReverb;
results = zeros(size(diffRange,2),size(HFDRange,2));
h = waitbar(0,'Analysing Reverb Parameters');
for jj = diffRange
    t.(pList{1}) = jj;
    for ii = HFDRange
        t.(pList{2}) = ii;
        y = process(t,x);
        y_ = mean(y,2);
        results(c_,c) = specCentroid(y_,fs);
        c = c + 1;
    end
    waitbar(jj,h);
    c = 1;
    c_ = c_ + 1;
end
close(h)
%
surf(results)

% p.rev.PreDelay = p.predelay;
% p.rev.HighCutFrequency = p.HFCut;
% p.rev.Diffusion = p.diffus;
% p.rev.DecayFactor = p.decay;
% p.rev.HighFrequencyDamping = p.HFDamp;
% p.rev.WetDryMix = p.wetDry;
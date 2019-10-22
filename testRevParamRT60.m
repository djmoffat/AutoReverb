close all
clear; clc
addpath('~/Google Drive/Matlab/myPath/');
addpath('~/Google Drive/Matlab/features/');

%% INIT
fs = 44100;
x = [1; zeros(1.5*fs-1,1)];



%%
iterList = 0:0.01:1;
c = 1;
c_ = 1;
% pList = {'predelay';'diffus';'decay';'HFDamp'};
pList = {'diffus';'decay'};
measureRT = zeros(size(iterList,2));
t = stdReverb;
h = waitbar(0,'Analysing Reverb Parameters')
for jj = iterList
    t.(pList{1}) = jj;
    
    for ii = iterList
        t.(pList{2}) = ii;
        y = process(t,x);
        measureRT(c,c_) = t60(y,fs)/1000;
        c = c + 1;
    end
    waitbar(jj,h);
    c = 1;
    c_ = c_ + 1;
end
close(h)
%%

surf(iterList,iterList,measureRT)

% p.rev.PreDelay = p.predelay;
% p.rev.HighCutFrequency = p.HFCut;
% p.rev.Diffusion = p.diffus;
% p.rev.DecayFactor = p.decay;
% p.rev.HighFrequencyDamping = p.HFDamp;
% p.rev.WetDryMix = p.wetDry;
classdef stdReverb < audioPlugin
    properties
        wetDry = 0.5;
        predelay = 0;
        diffus = 0.5;
        decay = 0.5;
        HFCut = 20000;
        HFDamp = 0.0005;
        fs;
    end
    properties (Constant)
        PluginInterface = audioPluginInterface(...
            'PluginName','AlgoReverb','VendorName','C4DM - FAST',...
            'VendorVersion','0.2','UniqueId','rev1',...
            audioPluginParameter('wetDry','DisplayName','Wet Dry Mix','Mapping',{'lin', 0, 1}),...
            audioPluginParameter('predelay','DisplayName','Pre Delay','Label','s','Mapping',{'lin', 0, 1}),...
            audioPluginParameter('diffus','DisplayName','Diffusion','Mapping',{'lin', 0, 1}),...
            audioPluginParameter('decay','DisplayName','Tail Decay','Mapping',{'lin', 0, 1}),...
            audioPluginParameter('HFCut','DisplayName','Low Pass Filter (Hz)','Label','Hz','Mapping',{'log', 20, 20000}),...
            audioPluginParameter('HFDamp','DisplayName','Damping','Mapping',{'lin', 0, 1}));
    end
    properties
        rev;
        init = true;
    end
    methods
        function p = stdReverb(p)
            p.fs = getSampleRate(p);
            p.rev = reverberator('SampleRate',p.fs);
        end
        function out = process(p,in)
            p = setParams(p);
            
            out = p.rev(in);
        end
        function p = reset(p)
            p.fs = getSampleRate(p);
            p.init = true;
        end
        function p = setParams(p)
            p.rev.PreDelay = p.predelay;
            p.rev.HighCutFrequency = p.HFCut;
             p.rev.Diffusion = p.diffus;
            p.rev.DecayFactor = p.decay;
            p.rev.HighFrequencyDamping = p.HFDamp;
            p.rev.WetDryMix = p.wetDry;
        end
    end
end

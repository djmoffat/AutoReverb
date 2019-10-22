classdef autoReverb < audioPlugin
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
        function p = autoReverb(p)
            p.fs = getSampleRate(p);
            p.rev = reverberator('SampleRate',p.fs);
        end
        function out = process(p,in)
%             p = setParams(p);
            p = automateParams(p);
            gain = 1 /(peak2rms(in))^3;
            out = p.rev(in) * gain;
        end
        function p = reset(p)
            p.fs = getSampleRate(p);
            p.init = true;
        end
        function p = automateParams(p)
            p.rev.WetDryMix = 1;
            p.rev.HighCutFrequency = 5000;
            
        end
        function p = setParams(p)
            p.rev.PreDelay = p.predelay;
            p.rev.HighCutFrequency = p.HFCut;
            p.rev.Diffusion = p.diffus;
            p.rev.DecayFactor = p.decay;
            p.rev.HighFrequencyDamping = p.HFDamp;
            p.rev.WetDryMix = p.wetDry;
        end
        function B = calculateBrightness(diffuse,HDDecay)
            p00 =   1.098e+04;
            p10 =       2.617;
            p01 =      -13.91;
            p20 =        5.17;
            p11 =       3.554;
            p02 =       14.34;
            p21 =      -2.798;
            p12 =       5.657;
            p03 =       18.86;
            p22 =       5.942;
            p13 =      -1.289;
            p04 =      -14.31;
            p23 =        5.01;
            p14 =      -2.241;
            p05 =      -11.82;
            x = diffuse;
            y = HDDecay;
            B = p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2 + p21*x^2*y +...
                    p12*x*y^2 + p03*y^3 + p22*x^2*y^2 + p13*x*y^3 + p04*y^4 +...
                    p23*x^2*y^3 + p14*x*y^4 + p05*y^5;
       

        end
        function T = calculateRevTime(p,diffus,decay)
           a =       942.4;
           b =   2.004e-05;
           c =       20.54;
           d =   1.617e+04;
           e =      -6.446;
           T = a + b*exp(c * decay) + d*exp(e * diffus);
        end
        function decay = estimateDecay(p,RT60,diffus)
            a =       942.4;
            b =   2.004e-05;
            c =       20.54;
            d =   1.617e+04;
            e =      -6.446;
           
            decay = log((a + d*exp(e * diffus) - RT60)/b)/c;
        end
        function dif = estimateDiffustion(p,RT60,decay)
            a =       942.4;
            b =   2.004e-05;
            c =       20.54;
            d =   1.617e+04;
            e =      -6.446;
           
            dif = log((a + b*exp(c * decay)- RT60)/d) / e;
        end
    end
end

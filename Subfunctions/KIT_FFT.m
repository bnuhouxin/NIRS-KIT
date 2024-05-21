function [nirsdata, ActualBandFrequency]=KIT_FFT(nirsdata,FilterModel,hpf,lpf)  
% nirsdata
% FilterModel:(1--highPass; 2--lowPass; 3--bandPass)
% fs: sampling frequency (Hz)

% hpf - high pass filter frequency (Hz)
%       Typical value is 0 to 0.02.
% lpf - low pass filter frequency (Hz)
%       Typical value is 0.5 to 3.


T = nirsdata.T;
sampleFreq = 1/T;
sampleLength = size(nirsdata.oxyData,1);
paddedLength = rest_nextpow2_one35(sampleLength);   


if FilterModel==1 % highpass, e.g., freq > 0.01 Hz
    
    [nirsdata, ActualBandFrequency]=NR_bandpassfilter(nirsdata,hpf,sampleFreq/2);
    
end

if FilterModel==2 % Lowpass, e.g., freq < 0.08 Hz
    
    [nirsdata, ActualBandFrequency]=NR_bandpassfilter(nirsdata,0,lpf);
    
end

if FilterModel==3 % Bandpass 
    
    [nirsdata, ActualBandFrequency]=NR_bandpassfilter(nirsdata,hpf,lpf);
    
end

end
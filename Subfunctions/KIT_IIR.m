function [hb,ha]=KIT_IIR(FilterModel,fs,FilterOrder,hpf,lpf)
% FilterModel:(1--highPass; 2--lowPass)
% FilterOrder
% fs: sampling frequency (Hz)

% hpf - high pass filter frequency (Hz)
%       Typical value is 0 to 0.02.
% lpf - low pass filter frequency (Hz)
%       Typical value is 0.5 to 3.

% hb,ha:IIR filter coefficients


wp=2*hpf/fs;
ws=2*lpf/fs;

if FilterModel==1
    [hb,ha]=butter(FilterOrder,wp,'high');
end
if FilterModel==2
    [hb,ha]=butter(FilterOrder,ws,'low');
end

end



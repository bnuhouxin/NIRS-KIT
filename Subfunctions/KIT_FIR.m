function [hb]=KIT_FIR(FilterModel,fs,FilterOrder,hpf,lpf,window)
% FilterModel:(1--highPass; 2--lowPass)
% FilterOrder
% fs: sampling frequency (Hz)

% hpf - high pass filter frequency (Hz)
%       Typical value is 0 to 0.02.
% lpf - low pass filter frequency (Hz)
%       Typical value is 0.5 to 3.

% window: (1--rectangular; 2--triang; 3--bartlett; 4--hamming;
% 5--hanning; 6--blackman;)

% example:
% n = 60;
% w = boxcar(n+1);
% wvtool(w)% display the window

% hb:FIR filter coefficients

if window==1
    w=rectwin(FilterOrder+1);
end
if window==2
    w=triang(FilterOrder+1);
end
if window==3
    w=bartlett(FilterOrder+1);
end
if window==4
    w=hamming(FilterOrder+1);
end
if window==5
    w=hanning(FilterOrder+1);
end
if window==6
    w=blackman(FilterOrder+1);
end

wp=2*hpf/fs;
ws=2*lpf/fs;

if FilterModel==1
    hb=fir1(FilterOrder,wp,'high',w);
end
if FilterModel==2
    hb=fir1(FilterOrder,ws,'low',w);
end

end
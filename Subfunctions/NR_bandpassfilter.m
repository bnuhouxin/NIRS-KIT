function [nirsdata, ActualBandFrequency]=NR_bandpassfilter(nirsdata,HighPass,LowPass)
% Bandpass filter 
% ___________________________________________________________________
% Copyright (C) 2007 Neuroimage Computing Group, State Key Laboratory of
% Cognitive Neuroscience and Learning
%
% Liang Wang, wanglbit@gmail.com
% @(#)nic_BandPassFilter.m  ver 2.0, 07/11/29
% Yujin Zhang, zyjinjin@gmail.com, modification


%Arrange the border of filtered frequency band
T = nirsdata.T;
sampleFreq = 1/T;
sampleLength = size(nirsdata.oxyData,1);
paddedLength = rest_nextpow2_one35(sampleLength);   
% paddedLength = sampleLength;
freqPrecision= sampleFreq/paddedLength;

%-------------------------------------------------------------
%| Generate low- and high- pass filter mask (referring to
%| rest_bandpass.m written by Song Xiaowei)
%-------------------------------------------------------------
% Generate low-pass filter mask
MaskData=ones(1,size(nirsdata.oxyData,2));
MaskData=logical(MaskData);
maskLowPass =repmat(MaskData, [paddedLength,1]);
maskHighPass=maskLowPass;
if (LowPass>=(sampleFreq/2))||(LowPass==0)
    maskLowPass(:,:)=1;	%All pass
    ActualLowpass = sampleFreq/2;
elseif (LowPass>0)&&(LowPass< freqPrecision)
    maskLowPass(:,:)=0;	% All stop
    ActualLowpass = 0;
else
    % Low pass, e.g., freq < 0.08 Hz
    idxCutoff	=round(LowPass./freqPrecision);
    ActualLowpass = idxCutoff * freqPrecision;
    idxCutoff2	= paddedLength+2 -idxCutoff;	   
    maskLowPass(idxCutoff+1:idxCutoff2-1,:)=0; 
%     maskLowPass(idxCutoff+2:idxCutoff2,:)=0; 
end
   
% Generate high-pass filter mask
if (HighPass < freqPrecision)
    maskHighPass(:,:)=1;	%All pass
    ActualHighpass=0;
elseif (HighPass >= (sampleFreq/2))
    maskHighPass(:,:)=0;	% All stop
    ActualHighpass = sampleFreq/2;
else
    % high pass, e.g., freq > 0.01 Hz
    idxCutoff	= round(HighPass./freqPrecision);
    ActualHighpass = idxCutoff * freqPrecision;
    idxCutoff2	= paddedLength+2 -idxCutoff;	  
    maskHighPass(1:idxCutoff-1,:)=0;
    maskHighPass(idxCutoff2+1:paddedLength,:)=0;
%     maskHighPass(1:idxCutoff,:)=0;
%     maskHighPass(idxCutoff2+2:paddedLength,:)=0;
end

%% Oxy
            %FFT
            slicesfreq =fft(nirsdata.oxyData, paddedLength, 1);
            %Mask redundant frequency components
%             FilterMask= squeeze(maskLowPass(:,:,k,:));
            slicesfreq(~maskLowPass)=0;
%             FilterMask=squeeze(maskHighPass(:,:,k,:));
            slicesfreq(~maskHighPass)=0;
            %inverse FFT
            nirsdata.oxyData =ifft(slicesfreq, paddedLength, 1);
            nirsdata.oxyData =nirsdata.oxyData(1:sampleLength,:);%remove the padded parts
%% Dxy
            %FFT
            slicesfreq =fft(nirsdata.dxyData, paddedLength, 1);
            %Mask redundant frequency components
%             FilterMask= squeeze(maskLowPass(:,:,k,:));
            slicesfreq(~maskLowPass)=0;
%             FilterMask=squeeze(maskHighPass(:,:,k,:));
            slicesfreq(~maskHighPass)=0;
            %inverse FFT
            nirsdata.dxyData =ifft(slicesfreq, paddedLength, 1);
            nirsdata.dxyData =nirsdata.dxyData(1:sampleLength,:);%remove the padded parts
%% Total
            %FFT
            slicesfreq =fft(nirsdata.totalData, paddedLength, 1);
            %Mask redundant frequency components
%             FilterMask= squeeze(maskLowPass(:,:,k,:));
            slicesfreq(~maskLowPass)=0;
%             FilterMask=squeeze(maskHighPass(:,:,k,:));
            slicesfreq(~maskHighPass)=0;
            %inverse FFT
            nirsdata.totalData =ifft(slicesfreq, paddedLength, 1);
            nirsdata.totalData =nirsdata.totalData(1:sampleLength,:);%remove the padded parts

ActualBandFrequency=[ActualHighpass ActualLowpass];

return
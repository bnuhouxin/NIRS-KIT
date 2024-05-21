function nirsdata=NR_filter(nirsdata,FilterMethod,FilterModel,FilterOrder,hpf,lpf)

% Filter on the input images
%
%
% Input:
% filter_mathod:  1 = IIR; 2 = FIR; 3 = FFT.
% filter_type: 1 = high pass; 2 = low pass; 3 = bandpass.
% 



if FilterMethod == 1 % IIR
    T=nirsdata.T;
    fs=1/T;
    
    switch FilterModel
        case {1,2}
        [hb,ha]=KIT_IIR(FilterModel,fs,FilterOrder,hpf,lpf);

        nirsdata.oxyData = filtfilt(hb,ha,nirsdata.oxyData); 
        nirsdata.dxyData = filtfilt(hb,ha,nirsdata.dxyData);
        nirsdata.totalData = filtfilt(hb,ha,nirsdata.totalData); 
        
        otherwise
        % first LP filtering
        [hb,ha]=KIT_IIR(2,fs,FilterOrder,'',lpf);

        nirsdata.oxyData = filtfilt(hb,ha,nirsdata.oxyData); 
        nirsdata.dxyData = filtfilt(hb,ha,nirsdata.dxyData);
        nirsdata.totalData = filtfilt(hb,ha,nirsdata.totalData); 
        
        % then HP filtering
        [hb,ha]=KIT_IIR(1,fs,FilterOrder,hpf,'');

        nirsdata.oxyData = filtfilt(hb,ha,nirsdata.oxyData); 
        nirsdata.dxyData = filtfilt(hb,ha,nirsdata.dxyData);
        nirsdata.totalData = filtfilt(hb,ha,nirsdata.totalData);
        
    end 
    
elseif FilterMethod == 2 % FIR
    window = 4; %  hamming window
    T=nirsdata.T;
    fs=1/T;
    
    switch FilterModel
        case {1,2}
        [hb]=KIT_FIR(FilterModel,fs,FilterOrder,hpf,lpf,window);

        nirsdata.oxyData = filtfilt(hb,1,nirsdata.oxyData);
        nirsdata.dxyData = filtfilt(hb,1,nirsdata.dxyData);
        nirsdata.totalData = filtfilt(hb,1,nirsdata.totalData);
    
        otherwise
        % first LP filtering
        [hb]=KIT_FIR(2,fs,FilterOrder,'',lpf,window);
        nirsdata.oxyData = filtfilt(hb,1,nirsdata.oxyData);
        nirsdata.dxyData = filtfilt(hb,1,nirsdata.dxyData);
        nirsdata.totalData = filtfilt(hb,1,nirsdata.totalData);
        
        % then HP filtering
        [hb]=KIT_FIR(1,fs,FilterOrder,hpf,'',window);
        nirsdata.oxyData = filtfilt(hb,1,nirsdata.oxyData);
        nirsdata.dxyData = filtfilt(hb,1,nirsdata.dxyData);
        nirsdata.totalData = filtfilt(hb,1,nirsdata.totalData);
       
    end
    
elseif FilterMethod == 3 % FFT
    
    [nirsdata, ActualBandFrequency] = KIT_FFT(nirsdata,FilterModel,hpf,lpf)
end

end

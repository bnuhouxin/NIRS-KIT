function [ALFF,mALFF,zALFF] = NR_alff_compute(data,ASamplePeriod,LowCutoff,HighCutoff)
   
% 	ASamplePeriod		TR, or like the variable name
% 	LowCutoff			the low edge of the pass band
% 	HighCutoff			the High edge of the pass band


    % Get the frequency index
    sampleFreq 	 = 1/ASamplePeriod;
    sampleLength = size(data,1);
    paddedLength = rest_nextpow2_one35(sampleLength); %2^nextpow2(sampleLength);
    if (LowCutoff >= sampleFreq/2) % All high included
        idx_LowCutoff = paddedLength/2 + 1;
    else % high cut off, such as freq > 0.01 Hz
        idx_LowCutoff = ceil(LowCutoff * paddedLength * ASamplePeriod + 1);
        % Change from round to ceil: idx_LowCutoff = round(LowCutoff *paddedLength *ASamplePeriod + 1);
    end
    if (HighCutoff>=sampleFreq/2)||(HighCutoff==0) % All low pass
        idx_HighCutoff = paddedLength/2 + 1;
    else % Low pass, such as freq < 0.08 Hz
        idx_HighCutoff = fix(HighCutoff *paddedLength *ASamplePeriod + 1);
        % Change from round to fix: idx_HighCutoff	=round(HighCutoff *paddedLength *ASamplePeriod + 1);
    end

data = detrend(data);

% Zero Padding
data = [data;zeros(paddedLength -sampleLength,size(data,2))]; %padded with zero

data = 2*abs(fft(data))/sampleLength;
 
 
ALFF = mean(data(idx_LowCutoff:idx_HighCutoff,:));
 

% mALFF
mALFF = ALFF./nanmean(ALFF);
% zALFF
zALFF = (ALFF-nanmean(ALFF))./nanstd(ALFF);
   
end
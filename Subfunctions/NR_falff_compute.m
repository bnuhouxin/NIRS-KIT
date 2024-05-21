function [fALFF,mfALFF,zfALFF] = NR_falff_compute(data,ASamplePeriod,LowCutoff,HighCutoff)

% [fALFF,mfALFF,zfALFF] = NR_falff_compute(data,ASamplePeriod,LowCutoff,HighCutoff,EntireLow,EntireHigh)
% 	ASamplePeriod		TR, or like the variable name
% 	LowCutoff			the low edge of the pass band
% 	HighCutoff			the High edge of the pass band
%   EntireLow           the low frequence in the whole band for fALFF
%   EntireHigh          the high frequence in the whole band for fALFF

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
    
    
%     if (EntireLow >= sampleFreq/2)
%         idx_EntireLow = paddedLength/2 + 1;
%         if idx_EntireLow == 1
%             idx_EntireLow = 2
%         end
%     else
%         idx_EntireLow = ceil(EntireLow * paddedLength * ASamplePeriod + 1);
%         if idx_EntireLow == 1
%             idx_EntireLow = 2
%         end
%     end
%     
%     if (EntireHigh >= sampleFreq/2)
%         idx_EntireHigh = paddedLength/2 + 1;
%     else
%         idx_EntireHigh = ceil(EntireHigh * paddedLength * ASamplePeriod + 1);
%     end
    

data = detrend(data);

% Zero Padding
data = [data;zeros(paddedLength -sampleLength,size(data,2))]; %padded with zero

data = 2*abs(fft(data))/sampleLength;

% Generate fALFF
% fALFF = sum(data(idx_LowCutoff:idx_HighCutoff,:)) ./ sum(data(idx_EntireLow:idx_EntireHigh,:));
fALFF = sum(data(idx_LowCutoff:idx_HighCutoff,:)) ./ sum(data(2:(paddedLength/2 + 1),:));
fALFF(~isfinite(fALFF) & ~isnan(fALFF))=0;


% mALFF
mfALFF = fALFF./nanmean(fALFF);
% zALFF
zfALFF = (fALFF-nanmean(fALFF))./nanstd(fALFF);





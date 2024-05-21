% function dodTDDR = hmrMotionCorrectTDDR(dod,SD,sample_rate)
%
% Corrects motion artifacts by computing the temporal derivative of the dod signal, 
% applying robust regression to reduce magnitude of outlying fluctuations, then 
% integrating to get the corrected signal.
%
% This function follows the procedure described in:
% Fishburn, F. A. et al. (2019). Temporal Derivative Distribution Repair (TDDR): A motion correction method for fNIRS. NeuroImage, 184, 171-179.
%
% INPUTS:
% dod:         delta_OD
% SD:          SD structure
% sample_rate: the sample rate of the signal
%
% OUTPUTS:
% dodTDDR:     dod after correction via TDDR
%
% LOG:
% Script by Frank Fishburn (fishburnf@upmc.edu) 10/03/2018
%

function [dodTDDR] = hmrMotionCorrectTDDR(dod,SD,sample_rate)

mlAct = SD.MeasListAct; % prune bad channels

lstAct = find(mlAct==1);
dodTDDR = dod;

for ii=1:length(lstAct)
    
    idx_ch = lstAct(ii);

    %% Preprocess: Separate high and low frequencies
    filter_cutoff = .5;
    filter_order = 3;
    Fc = filter_cutoff * 2/sample_rate;
    if Fc<1
        [fb,fa] = butter(filter_order,Fc);
        signal_low = filtfilt(fb,fa,dod(:,idx_ch));
    else
        signal_low = dod(:,idx_ch);
    end
    signal_high = dod(:,idx_ch) - signal_low;

    %% Initialize
    tune = 4.685;
    D = sqrt(eps(class(dod)));
    mu = inf;
    iter = 0;

    %% Step 1. Compute temporal derivative of the signal
    deriv = diff(signal_low);

    %% Step 2. Initialize observation weights
    w = ones(size(deriv));

    %% Step 3. Iterative estimation of robust weights
    while iter < 50

        iter = iter + 1;
        mu0 = mu;

        % Step 3a. Estimate weighted mean
        mu = sum( w .* deriv ) / sum( w );

        % Step 3b. Calculate absolute residuals of estimate
        dev = abs(deriv - mu);

        % Step 3c. Robust estimate of standard deviation of the residuals
        sigma = 1.4826 * median(dev);

        % Step 3d. Scale deviations by standard deviation and tuning parameter
        r = dev / (sigma * tune);

        % Step 3e. Calculate new weights accoring to Tukey's biweight function
        w = ((1 - r.^2) .* (r < 1)) .^ 2;

        % Step 3f. Terminate if new estimate is within machine-precision of old estimate
        if abs(mu-mu0) < D*max(abs(mu),abs(mu0))
            break;
        end

    end

    %% Step 4. Apply robust weights to centered derivative
    new_deriv = w .* (deriv-mu);

    %% Step 5. Integrate corrected derivative
    signal_low_corrected = cumsum([0; new_deriv]);

    %% Postprocess: Center the corrected signal
    signal_low_corrected = signal_low_corrected - mean(signal_low_corrected);

    %% Postprocess: Merge back with uncorrected high frequency component
    dodTDDR(:,idx_ch) = signal_low_corrected + signal_high;
    
end

end

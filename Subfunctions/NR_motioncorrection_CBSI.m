function nirsdata = NR_motioncorrection_CBSI(nirsdata)

% Perform a correlation-based signal improvement of the concentration changes in order to correct for motion artifacts.  
% The algorithm follows the procedure described by Cui et al.,NeuroImage, 49(4), 3039-46 (2010).
%

nch = nirsdata.nch;
for ii = 1:nch
    oxyData = nirsdata.oxyData(:,ii);
    dxyData = nirsdata.dxyData(:,ii);
    sd_oxy = std(oxyData,0,1);
    sd_dxy = std(dxyData,0,1);
    alfa = sd_oxy/sd_dxy;
    nirsdata.oxyData(:,ii) = 0.5*(oxyData-alfa*dxyData);
    nirsdata.dxyData(:,ii) = -(1/alfa)*nirsdata.oxyData(:,ii);
    nirsdata.totalData(:,ii) =  nirsdata.oxyData(:,ii) + nirsdata.dxyData(:,ii);
end

end
function nirsdata =  NR_motioncorrection(nirsdata,method)

% NR_motioncorrection with TDDR or CBSI method

if method == 1 % CBSI
    SR = 1/nirsdata.T;
    nirsdata.oxyData = TDDR(nirsdata.oxyData,SR);
    nirsdata.dxyData = TDDR(nirsdata.dxyData,SR);
    nirsdata.totalData = TDDR(nirsdata.totalData,SR);
elseif method ==2 % TDDR   
    nirsdata = NR_motioncorrection_CBSI(nirsdata);
end

end
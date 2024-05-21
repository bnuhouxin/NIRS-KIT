function nirsdata =  NR_detrend(nirsdata,order)
tp=size(nirsdata.oxyData,1);
for ch=1:size(nirsdata.oxyData,2)
    p_oxy=polyfit([1:tp]',nirsdata.oxyData(:,ch),order);
    base_oxy=polyval(p_oxy,1:tp);
    nirsdata.oxyData(:,ch)=nirsdata.oxyData(:,ch)-base_oxy';
    
    p_dxy=polyfit([1:tp]',nirsdata.dxyData(:,ch),order);
    base_dxy=polyval(p_dxy,1:tp);
    nirsdata.dxyData(:,ch)=nirsdata.dxyData(:,ch)-base_dxy';

    p_total=polyfit([1:tp]',nirsdata.totalData(:,ch),order);
    base_total=polyval(p_total,1:tp);
    nirsdata.totalData(:,ch)=nirsdata.totalData(:,ch)-base_total';
end

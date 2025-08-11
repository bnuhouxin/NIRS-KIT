function nirs_data =  NID_detrend(nirs_data,order,hbtype)

switch hbtype
    case 'oxyData'
        tp=size(nirs_data.oxyData,1);
        for ch=1:size(nirs_data.oxyData,2)
            p_oxy=polyfit([1:tp]',nirs_data.oxyData(:,ch),order);
            base_oxy=polyval(p_oxy,1:tp);
            nirs_data.oxyData(:,ch)=nirs_data.oxyData(:,ch)-base_oxy';
        end
    case 'dxyData'
        tp=size(nirs_data.dxyData,1);
        for ch=1:size(nirs_data.dxyData,2)
            p_dxy=polyfit([1:tp]',nirs_data.dxyData(:,ch),order);
            base_dxy=polyval(p_dxy,1:tp);
            nirs_data.dxyData(:,ch)=nirs_data.dxyData(:,ch)-base_dxy';
        end
    case 'totalData'
        tp=size(nirs_data.totalData,1);
        for ch=1:size(nirs_data.totalData,2)
            p_total=polyfit([1:tp]',nirs_data.totalData(:,ch),order);
            base_total=polyval(p_total,1:tp);
            nirs_data.totalData(:,ch)=nirs_data.totalData(:,ch)-base_total';
        end
end
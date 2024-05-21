function [nirsdata,ks]=NK_SignalSeparation_Yamada(nirsdata)
% Input:
% nirsdata
% kf: hbr_f= kf*hbr_r;
% Empirical value,-1<kf<0,(default in paper is -0.6)
% see the table 1. Estimation of  based on existing fNIRS studies
% step: step in estimation of ks, e.g.0.05,0.1

% Output:
% nirsdata
% ks: hbr_s=ks*hbr_s; 0<ks<1

% Yamada T, Umeyama S, Matsuda K (2012) Separation of fNIRS Signals into Functional and Systemic
% Components Based on Differences in Hemodynamic Modalities. PLOS ONE 7(11): e50271.
% https://doi.org/10.1371/journal.pone.0050271

% written by Zhang Zong
% 21/09/2020

%% parameters defination

kf = -0.6;
step = 0.05;

%% determination of ks

oxyData=nirsdata.oxyData;
dxyData=nirsdata.dxyData;
% normalized the start to zero
oxyData=oxyData-ones(size(oxyData,1),1)*oxyData(1,:); % .*
dxyData=dxyData-ones(size(dxyData,1),1)*dxyData(1,:); % .*


% output initialization
oxyData_f=zeros(size(oxyData));
dxyData_f=zeros(size(oxyData));

oxyData_s=zeros(size(oxyData));
dxyData_s=zeros(size(oxyData));


for ch=1:size(nirsdata.oxyData,2)
    oxyData_ch=oxyData(:,ch);
    dxyData_ch=dxyData(:,ch);
    
    ks_vector=[0:step:1];
    mi_hbofs=ones(size(ks_vector));
    mi_idx=1;
    
    for ks=0:step:1
        a=1/(kf-ks);
        b=[-1*ks,1;-kf*ks,kf];
        c=[kf,-1;kf*ks,-1*ks];
        hbf=a.*b*[oxyData_ch';dxyData_ch'];
        hbs=a.*c*[oxyData_ch';dxyData_ch'];
        
        % mutual information of hbo_f and hbo_s
        x=hbf(1,:); % hbo_f
        y=hbs(1,:); % hbo_s
        
        perVa=99.5;% percentiles of the values, avoid extreme value
        
        [x_des]= prctile(x,[100-perVa,perVa]);
        [y_des]= prctile(y,[100-perVa,perVa]);
        
        ncell=ceil(length(x)^(1/3));
        descriptor=[x_des(1),x_des(2),ncell;y_des(1),y_des(2),ncell];
        [mi,nbias,sigma,descriptor] =information(x,y,descriptor);
        mi_hbofs(mi_idx)=mi;
        mi_idx=mi_idx+1;
        
    end
    
    [v,idx]=sort(mi_hbofs);
    ks_estimated=ks_vector(idx(1));
    
    % Actual separation
    a=1/(kf-ks_estimated);
    b=[-1*ks_estimated,1;-kf*ks_estimated,kf];
    c=[kf,-1;kf*ks_estimated,-1*ks_estimated];
    hbf=a.*b*[oxyData_ch';dxyData_ch'];
    hbs=a.*c*[oxyData_ch';dxyData_ch'];
    
    
    oxyData_f(:,ch)=hbf(1,:);
    dxyData_f(:,ch)=hbf(2,:);
    
    oxyData_s(:,ch)=hbs(1,:);
    dxyData_s(:,ch)=hbs(2,:);
    
end

nirsdata.oxyData=oxyData_f;
nirsdata.dxyData=dxyData_f;

end
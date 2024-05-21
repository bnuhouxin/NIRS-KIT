function [hb, hbo, hbt] = mes2hb(mesData, waveLength, baseline)
% function [hb, hbo, hbt] = mes2hb(mesData, waveLength, baseline)
%
% mesData: Nx2 matrix.  1st column: measurement data for ~700nm, 2nd for
%   ~830 nm. 
% waveLength: an array of size 2, the exact wavelengths of measurement.
% The first element is wavelenth for 700nm, the second for 830nm.
% baseline: array of size 2, the onset and offset of the baseline. unit is
% not second, but simply index.
%
% hb, hbo, hbt: concentration of deoxy-hb, oxy-hb and total.
%
% Note: the baseline part of the data is removed from hb, hbo and hbt.  So
% the length of these returned variables are less than the mesData.
%
% Example:
%   hb, hbo, hbt]=mes2hb(mes, [701.2 831.6], [1 100]);
%
% Xu Cui
% revised 2008-5-7
% 2007-10-02

% DPF under 25 years
% DPF_700=CalcDPF (25, wlen_700);
% DPF_830=CalcDPF (25, wlen_830);
% Scholkmann, F., & Wolf, M. (2013). 
% General equation for the differential pathlength factor of the frontal human head depending
% on wavelength and age. Journal of biomedical optics, 18(10), 105004.

load all_e_coef.mat
e_coef = all_e_coef;

wlen_700     = waveLength(1);
wlen_830     = waveLength(2);
data_fit_700 = mean(mesData([baseline(1):baseline(2)],1));
data_fit_830 = mean(mesData([baseline(1):baseline(2)],2));

eoxy_700 = find_e(wlen_700, 'oxy', e_coef);
eoxy_830 = find_e(wlen_830, 'oxy', e_coef);
edeo_700 = find_e(wlen_700, 'deoxy', e_coef);
edeo_830 = find_e(wlen_830, 'deoxy', e_coef);

a_700 = zeros(1, size(mesData,1));
a_830 = zeros(1, size(mesData,1));

pos = find(sign(mesData(:, 1)) * data_fit_700 > 0);
a_700(pos) = log(data_fit_700./mesData(pos,1));

pos = find(sign(mesData(:, 2)) * data_fit_830 > 0);
a_830(pos) = log(data_fit_830./mesData(pos,2));

hb = zeros(size(mesData,1),1);
hbo = zeros(size(mesData,1),1);
hbt = zeros(size(mesData,1),1);

%% ************ motified by zong zhang 2021.05.19 **
% DPF under 25 years
DPF_700=CalcDPF (25, wlen_700);
DPF_830=CalcDPF (25, wlen_830);
% Source-Detecter Distance
L=3;% cm

%****** Oxy Hb ******
if ((eoxy_700*edeo_830 - eoxy_830*edeo_700)~=0)
	hbo = (1/L).*(a_700*edeo_830/DPF_700 - a_830*edeo_700/DPF_830)/(eoxy_700*edeo_830 - eoxy_830*edeo_700);
end

%****** Deoxy Hb ******
if ((edeo_700*eoxy_830 - edeo_830*eoxy_700)~=0)
	hb = (1/L).*(a_700*eoxy_830/DPF_700 - a_830*eoxy_700/DPF_830)/(edeo_700*eoxy_830 - edeo_830*eoxy_700);
end

%% ************ motified by zong zhang 2021.05.19 **


hbt = hbo + hb;
  
hb(baseline(1):baseline(2)) = [];
hbo(baseline(1):baseline(2)) = [];
hbt(baseline(1):baseline(2)) = [];
hb = hb';
hbo = hbo';
hbt = hbt';

%%
% lookup coefficient from a table.  If not exist, do interpolation
function e = find_e(waveLength, oxydeoxy, table)
if(strcmp(oxydeoxy, 'oxy'))
    col = 3;
elseif(strcmp(oxydeoxy, 'deoxy'))
    col = 2;
else
    error('You need to specify deoxy or oxy');
end

l = floor(waveLength);
u = floor(waveLength) + 1;

lc = table(find(table(:,1)==l),col);
uc = table(find(table(:,1)==u),col);

e = (uc - lc) / (u - l) * (waveLength - l) + lc;
return;
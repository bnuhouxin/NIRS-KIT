function nirs_data =  NID_resample(nirs_data,newT,hbtype)

% NR_resample is used for down sampling data
% resample is a matlab function, help it to view more details

T = nirs_data.T;

Q = round(10/T);
P = round(10/newT);
switch hbtype
    case 'oxyData'
        nirs_data.oxyData = resample(nirs_data.oxyData,P,Q);
    case 'dxyData'
        nirs_data.dxyData = resample(nirs_data.dxyData,P,Q);
    case 'totalData'
        nirs_data.totalData = resample(nirs_data.totalData,P,Q);
end
vector_new=zeros(length(nirs_data.oxyData),1);

[C,~,~]=unique(nirs_data.vector_onset);
label_onset=setdiff(C,0);

for ii=1:length(label_onset)
    onset_pos=find(nirs_data.vector_onset==label_onset(ii));
    new_pos=round(onset_pos*T/newT);
    if new_pos == 0
        new_pos=1;
    elseif new_pos > length(vector_new)
        new_pos=length(vector_new);
    end
    vector_new(new_pos)=label_onset(ii);
end
nirs_data.vector_onset=vector_new;
nirs_data.T =newT;
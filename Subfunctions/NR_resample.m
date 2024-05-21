function nirsdata =  NR_resample(nirsdata,newT)

% NR_resample is used for down sampling data
% resample is a matlab function, help it to view more details

T = nirsdata.T;

Q = round(10/T);
P = round(10/newT);

nirsdata.oxyData = resample(nirsdata.oxyData,P,Q);
nirsdata.dxyData = resample(nirsdata.dxyData,P,Q);
nirsdata.totalData = resample(nirsdata.totalData,P,Q);

vector_new=zeros(length(nirsdata.oxyData),1);

[C,~,~]=unique(nirsdata.vector_onset);
label_onset=setdiff(C,0);

for ii=1:length(label_onset)
    onset_pos=find(nirsdata.vector_onset==label_onset(ii));
    new_pos=round(onset_pos*T/newT);
    if new_pos == 0
        new_pos=1;
    elseif new_pos > length(vector_new)
        new_pos=length(vector_new);
    end
    vector_new(new_pos)=label_onset(ii);
end
nirsdata.vector_onset=vector_new;
nirsdata.T =newT;
function nirs_data =  NID_segment(nirs_data,left,right,hbtype)

% NR_segment cut the first 'left' seconds  and last 'right' seconds data

T = nirs_data.T;
% nirs_data.oxyData = nirs_data.oxyData(round(left/T)+1:end-round(right/T),:);
% nirs_data.dxyData = nirs_data.dxyData(round(left/T)+1:end-round(right/T),:);
% nirs_data.totalData = nirs_data.totalData(round(left/T)+1:end-round(right/T),:);
eval(['nirs_data.' hbtype ' = nirs_data.' hbtype '(round(left/T)+1:end-round(right/T),:);'])
nirs_data.vector_onset=nirs_data.vector_onset(round(left/T)+1:end-round(right/T),:);
end
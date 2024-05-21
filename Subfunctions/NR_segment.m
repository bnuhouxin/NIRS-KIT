function nirsdata =  NR_segment(nirsdata,left,right)

% NR_segment cut the first 'left' seconds  and last 'right' seconds data

T = nirsdata.T;
nirsdata.oxyData = nirsdata.oxyData(round(left/T)+1:end-round(right/T),:);
nirsdata.dxyData = nirsdata.dxyData(round(left/T)+1:end-round(right/T),:);
nirsdata.totalData = nirsdata.totalData(round(left/T)+1:end-round(right/T),:);
nirsdata.vector_onset=nirsdata.vector_onset(round(left/T)+1:end-round(right/T),:);
end
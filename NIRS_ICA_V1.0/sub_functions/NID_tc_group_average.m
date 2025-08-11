function [tc_each_p,g_onset,g_offset] = NID_tc_group_average(tc,onset,offset)
%NID_BL_AVERAGE Summary of this function goes here
%This function calculate the block average across participants
%Detailed explanation goes here

min_rest=min(onset);
min_task=min(offset-onset);
durs=offset-onset;
tc_each_p=zeros(length(tc),2*min_rest+min_task);

for p=1:length(tc)
    mask=zeros(length(tc{p}),1);
    %cut points more than minimum rest
    mask((onset(p)-min_rest+1):(offset(p)+min_rest))=1;
    %cut points more than minimum task
    c=onset(p)+floor((durs(p))/2);
    if c~=(c+durs(p)-min_task)
        mask(c:(c+durs(p)-min_task))=0;
    end
    tc_each_p(p,:)=tc{p}(mask>0);
end

g_onset=min_rest;
g_offset=min_rest+min_task;
function [tc_aver,onset,offset] = NID_bl_average(tc,des_tc)
%NID_BL_AVERAGE Summary of this function goes here
%This function calculate the block average using timecourse tc and
%reference curve des_tc
%Detailed explanation goes here

%get minimum block length
offset=des_tc.onset+des_tc.dur;
rest_onset=[0; offset];
rest_dur=[des_tc.onset;length(des_tc.design)]-rest_onset;
rest_offset=floor(min(rest_dur)/2);
min_bl=min(des_tc.dur);

% min_rest=
%%adjust the block length
vec_onset=zeros(length(tc),1);

for bl=1:length(des_tc.onset)

    bl_st=des_tc.onset(bl);
    bl_ed=des_tc.onset(bl)+des_tc.dur(bl)-1;
    
    vec_onset(bl_st:bl_ed)=1;
    %set rest offset
    vec_onset((bl_st-rest_offset):(bl_st-1))=1;
    vec_onset((bl_ed+1):(bl_ed+rest_offset))=1;
    
    
    c=bl_st+floor((bl_ed-bl_st)/2);
    %     tc(c:(c+des_tc.dur(bl)-min_bl-1))=[];
    vec_onset(c:(c+des_tc.dur(bl)-min_bl-1))=0;
    
end

%get adjusted block time course
tmp=tc(vec_onset>0);
tc_bl_ad=reshape(tmp,[(min_bl+rest_offset*2),length(des_tc.onset)]);
% tc_bl_ad=tc_bl_ad';
%average the time course
tc_aver=mean(tc_bl_ad,2);
onset=rest_offset;
offset=rest_offset+min_bl;

end


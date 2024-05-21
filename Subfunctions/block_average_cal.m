function [mean_ba,xAxes,ref_ba,max_dur] = block_average_cal(onset, duration, pre, pst, timeData,T)

max_dur = max(duration);
xAxes = 1:pre+max_dur+pst+1;  
xAxes = xAxes-1-pre;
cond_ba = zeros(pre+max_dur+pst+1,length(onset))*NaN;

ref = zeros(pre+max_dur+pst+1,1);
ref(pre+1:pre+1+max_dur,1) = 1;
[hrf,~] = spm_hrf(T);
refwave=conv(ref,hrf);
ref_ba=refwave(1:length(ref),1);

for block_nm = 1:length(onset)
   if onset(block_nm) - pre < 1
       cond_ba(pre+2-onset(block_nm):pre,block_nm) = ...
           timeData(1:onset(block_nm)-1,1);
   else
       cond_ba(1:pre,block_nm) = timeData(onset(block_nm)-pre:onset(block_nm)-1,1);
   end

   cond_ba(pre+1:pre+duration(block_nm)+1,block_nm) = ...
       timeData(onset(block_nm):onset(block_nm)+duration(block_nm),1);

   if onset(block_nm)+duration(block_nm)+pst > length(timeData)
       cond_ba(pre+max_dur+2:pre+max_dur+1+length(timeData)-onset(block_nm)-duration(block_nm),block_nm) = ...
           timeData(onset(block_nm)+duration(block_nm)+1:length(timeData),1);
   else
       cond_ba(pre+max_dur+2:pre+max_dur+pst+1,block_nm) = ...
           timeData(onset(block_nm)+duration(block_nm)+1:onset(block_nm)+duration(block_nm)+pst,1);
   end

end

mean_ba = nanmean(cond_ba,2);

end
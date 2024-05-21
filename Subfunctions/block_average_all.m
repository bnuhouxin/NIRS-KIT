function [mean_all_ba,xAxes,ref_ba,max_dur,sub_waves] = block_average_all(handles,pre,pst,ch_nm,sig_ty,T,ifprep)

inpath = get(handles.addpath,'userdata');
subname = get(handles.sublistbox,'string');
% subfile=fullfile(inpath,[subname{1},'.mat']);


usd=get(handles.Task_Opt_Pannel,'userdata');
usercond=usd{1,1};
if get(handles.DesignType,'value') == 2 && ~isempty(get(handles.diffcondbox,'userdata'))
    des_inf = get(handles.diffcondbox,'userdata');
    des_cond = des_inf(:,usercond);
    
    sub_durs = [];
    for subid = 1:size(des_cond,1)
       if get(handles.Units,'value') == 2
            des_cond{subid,1} = round(des_cond{subid,1}./T);
       end
       sub_durs = [sub_durs;des_cond{subid,1}(:,2)];
    end
    
    max_dur = max(sub_durs);
else 
    if get(handles.Units,'value')==2
        usd{2,1}{usercond,1} = round(usd{2,1}{usercond,1}./T);
        usd{3,1}{usercond,1} = round(usd{3,1}{usercond,1}./T);
    end
    us_des = {[usd{2,1}{usercond,1}',usd{3,1}{usercond,1}']};
    
    des_cond = repmat(us_des,size(subname));
    
    max_dur = max(usd{3,1}{usercond,1});
end

xAxes = 1:pre+max_dur+pst+1;  
xAxes = xAxes-1-pre;

ref = zeros(pre+max_dur+pst+1,1);
ref(pre+1:pre+1+max_dur,1) = 1;
[hrf,~] = spm_hrf(T);
refwave=conv(ref,hrf);
ref_ba=refwave(1:length(ref),1);


if ifprep == 1
    preprocessSet = NR_generate_preprossSet_view(handles);
    step={};  
    for i=1:length(preprocessSet)  
        if size(preprocessSet{i},2) == 1  % for customized function
            step{i} = ['prepdata=',preprocessSet{i}{1},'(','nirsdata',');'];
        else
            step{i}=['prepdata=',preprocessSet{i}{1},'(','nirsdata',','];
            for j=2:length(preprocessSet{i})-1
                step{i}=[step{i},preprocessSet{i}{j},','];
            end
            step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},');'];
        end
    end
end

all_sub_ba = [];
for subid = 1:size(subname,1)
    
    subfile = fullfile(inpath,[subname{subid},'.mat']);
    load(subfile);
    
    onset = des_cond{subid,1}(:,1);
    duration = des_cond{subid,1}(:,2);

    if ifprep == 0  % raw data
        if isfield(nirsdata,'exception_channel')
            if ~all(nirsdata.exception_channel ==0)
                nirsdata.oxyData(:,nirsdata.exception_channel == 1) = NaN;
                nirsdata.dxyData(:,nirsdata.exception_channel == 1) = NaN;
                nirsdata.totalData(:,nirsdata.exception_channel == 1) = NaN;
            end
        end
        
        if strcmp(sig_ty,'oxyData')
            sub_ba = sub_block_average(pre,pst,onset,duration,max_dur,ch_nm,nirsdata.oxyData);
        elseif strcmp(sig_ty,'dxyData')
            sub_ba = sub_block_average(pre,pst,onset,duration,max_dur,ch_nm,nirsdata.dxyData);
        elseif strcmp(sig_ty,'totalData')
            sub_ba = sub_block_average(pre,pst,onset,duration,max_dur,ch_nm,nirsdata.totalData);
        end
        
    else  % prep data
        for j=1:length(step)
            eval(step{j});
            prepdata.preprocessSet=preprocessSet(1:j);
        end  
        
        if isfield(prepdata,'exception_channel')
            if ~all(prepdata.exception_channel ==0)
                prepdata.oxyData(:,prepdata.exception_channel == 1) = NaN;
                prepdata.dxyData(:,prepdata.exception_channel == 1) = NaN;
                prepdata.totalData(:,prepdata.exception_channel == 1) = NaN;
            end
        end
        
        if strcmp(sig_ty,'oxyData')
            sub_ba = sub_block_average(pre,pst,onset,duration,max_dur,ch_nm,prepdata.oxyData);
        elseif strcmp(sig_ty,'dxyData')
            sub_ba = sub_block_average(pre,pst,onset,duration,max_dur,ch_nm,prepdata.dxyData);
        elseif strcmp(sig_ty,'totalData')
            sub_ba = sub_block_average(pre,pst,onset,duration,max_dur,ch_nm,prepdata.totalData);
        end
    end

    all_sub_ba = [all_sub_ba,sub_ba];
end

mean_all_ba = nanmean(all_sub_ba,2);

end



function sub_ba = sub_block_average(pre,pst,onset,duration,max_dur,ch_nm,subdata)
    
    cond_ba = zeros(pre+max_dur+pst+1,length(onset))*NaN;
    
    if size(ch_nm,2) > 1
        timeData = nanmean(subdata(:,ch_nm),2);
    else
        timeData = subdata(:,ch_nm);
    end
    
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
    
    sub_ba = nanmean(cond_ba,2);
    
end
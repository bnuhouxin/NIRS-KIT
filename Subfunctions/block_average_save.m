function group_ba_data = block_average_save(handles)

%%
data = get(handles.axestimeseries,'userdata');
nirsdataRaw = data.raw;
T = nirsdataRaw.T;
nch = nirsdataRaw.nch;

pre = str2num(get(handles.rangeLeft,'string'));
pst = str2num(get(handles.rangeRight,'string'));

unit_ty = get(handles.rangeType,'value');
if unit_ty == 1
   pre = round(pre./T);
   pst = round(pst./T);
end

inpath = get(handles.addpath,'userdata');
subname = get(handles.sublistbox,'string');
%%

if get(handles.DesignType,'value') == 2 && ~isempty(get(handles.diffcondbox,'userdata'))
    des_inf = get(handles.diffcondbox,'userdata');
    cond_nm = get(handles.diffcondbox,'string');

    sub_durs = cell(1,size(des_inf,2));
    for usercond = 1:size(des_inf,2)
        for subid = 1:size(des_inf,1)
           if get(handles.Units,'value') == 2
                des_inf{subid,usercond} = round(des_inf{subid,usercond}./T);
           end
           sub_durs{1,usercond} = [sub_durs{1,usercond};des_inf{subid,usercond}(:,2)];
        end
        max_dur(usercond) = max(sub_durs{1,usercond}); 
    end 
    
else
    cond_userdata=get(handles.cond_listbox,'userdata');
    usd = get(handles.Task_Opt_Pannel,'userdata');
    
    usd = usd(2:end,1);
    
    for usercond = 1:size(usd{1},1)
        
        cond_nm{usercond,1} = cond_userdata{2+(usercond-1)*4}(18:end);
        
        if get(handles.Units,'value')==2
            usd{1,1}{usercond,1} = round(usd{1,1}{usercond,1}./T);
            usd{2,1}{usercond,1} = round(usd{2,1}{usercond,1}./T);
        end
        
        des_inf{1,usercond}(:,1) = usd{1,1}{usercond,1}';
        des_inf{1,usercond}(:,2) = usd{2,1}{usercond,1}';
        
        max_dur(usercond) = max(des_inf{1,usercond}(:,2)); 
        
    end
    
    des_inf = repmat(des_inf,size(subname));
    
end

for usercond = 1:size(des_inf,2)
    xAxes = 1:pre+max_dur(usercond)+pst+1;  
    xAxes = xAxes-1-pre;
    if get(handles.rangeType,'value') == 1
        xAxes=xAxes*T;
    end
    eval(['group_ba_data.raw.',cond_nm{usercond},'.xAxes = xAxes']);

    ref = zeros(pre+max_dur(usercond)+pst+1,1);
    ref(pre+1:pre+1+max_dur(usercond),1) = 1;
    [hrf,~] = spm_hrf(T);
    refwave=conv(ref,hrf);
    ref_ba=refwave(1:length(ref),1);
    eval(['group_ba_data.',cond_nm{usercond},'.ref_ba_oxy = ref_ba;']);
    eval(['group_ba_data.',cond_nm{usercond},'.ref_ba_dxy = ref_ba*-1;']);
    eval(['group_ba_data.',cond_nm{usercond},'.ref_ba_total = ref_ba']);
end

if get(handles.preprocessed,'value') == 1
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


for  usercond = 1:size(des_inf,2)
    for ch_nm = 1:nch
        eval(['group_ba_data.raw.across_subjects.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);
        eval(['group_ba_data.raw.across_subjects.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);
        eval(['group_ba_data.raw.across_subjects.total.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);

        eval(['group_ba_data.raw.across_subxblock.oxy .',cond_nm{usercond},'.ch',num2str(ch_nm),'= []']);
        eval(['group_ba_data.raw.across_subxblock.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);
        eval(['group_ba_data.raw.across_subxblock.total.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);

        if get(handles.preprocessed,'value') == 1
            eval(['group_ba_data.prep.across_subjects.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);
            eval(['group_ba_data.prep.across_subjects.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);
            eval(['group_ba_data.prep.across_subjects.total.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);

            eval(['group_ba_data.prep.across_subxblock.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);
            eval(['group_ba_data.prep.across_subxblock.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);
            eval(['group_ba_data.prep.across_subxblock.total.',cond_nm{usercond},'.ch',num2str(ch_nm),' = []']);
        end
    end
end


for subid = 1:size(subname,1)

    subfile = fullfile(inpath,[subname{subid},'.mat']);
    load(subfile);

        onset = des_inf{subid,1}(:,1);
        duration = des_inf{subid,1}(:,2);

        if isfield(nirsdata,'exception_channel')
            if ~all(nirsdata.exception_channel ==0)
                nirsdata.oxyData(:,nirsdata.exception_channel == 1) = NaN;
                nirsdata.dxyData(:,nirsdata.exception_channel == 1) = NaN;
                nirsdata.totalData(:,nirsdata.exception_channel == 1) = NaN;
            end
        end

        for  usercond = 1:size(des_inf,2)
            for ch_nm = 1:nch
                [oxy_sub_ba,oxy_cond_ba] = sub_block_average(pre,pst,onset,duration,max_dur(usercond),ch_nm,nirsdata.oxyData);
                [dxy_sub_ba,dxy_cond_ba] = sub_block_average(pre,pst,onset,duration,max_dur(usercond),ch_nm,nirsdata.dxyData);
                [tot_sub_ba,tot_cond_ba] = sub_block_average(pre,pst,onset,duration,max_dur(usercond),ch_nm,nirsdata.totalData);
                
                
                eval(['group_ba_data.raw.across_subjects.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.raw.across_subjects.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',oxy_sub_ba];']);
                eval(['group_ba_data.raw.across_subjects.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.raw.across_subjects.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',dxy_sub_ba];']);
                eval(['group_ba_data.raw.across_subjects.total.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.raw.across_subjects.total.',cond_nm{usercond},'.ch',num2str(ch_nm),',tot_sub_ba];']);
                
                eval(['group_ba_data.raw.across_subxblock.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.raw.across_subxblock.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',oxy_cond_ba];']);
                eval(['group_ba_data.raw.across_subxblock.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.raw.across_subxblock.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',dxy_cond_ba];']);
                eval(['group_ba_data.raw.across_subxblock.total.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.raw.across_subxblock.total.',cond_nm{usercond},'.ch',num2str(ch_nm),',tot_cond_ba];']);
            end
        end

        
        if  get(handles.preprocessed,'value') == 1
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


            for  usercond = 1:size(des_inf,2)
                for ch_nm = 1:nch
                    [oxy_sub_ba,oxy_cond_ba] = sub_block_average(pre,pst,onset,duration,max_dur(usercond),ch_nm,prepdata.oxyData);
                    [dxy_sub_ba,dxy_cond_ba] = sub_block_average(pre,pst,onset,duration,max_dur(usercond),ch_nm,prepdata.dxyData);
                    [tot_sub_ba,tot_cond_ba] = sub_block_average(pre,pst,onset,duration,max_dur(usercond),ch_nm,prepdata.totalData);


                    eval(['group_ba_data.prep.across_subjects.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.prep.across_subjects.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',oxy_sub_ba];']);
                    eval(['group_ba_data.prep.across_subjects.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.prep.across_subjects.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',dxy_sub_ba];']);
                    eval(['group_ba_data.prep.across_subjects.total.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.prep.across_subjects.total.',cond_nm{usercond},'.ch',num2str(ch_nm),',tot_sub_ba];']);

                    eval(['group_ba_data.prep.across_subxblock.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.prep.across_subxblock.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',oxy_cond_ba];']);
                    eval(['group_ba_data.prep.across_subxblock.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.prep.across_subxblock.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',dxy_cond_ba];']);
                    eval(['group_ba_data.prep.across_subxblock.total.',cond_nm{usercond},'.ch',num2str(ch_nm),' = [group_ba_data.prep.across_subxblock.total.',cond_nm{usercond},'.ch',num2str(ch_nm),',tot_cond_ba];']);
                end
            end

        end
end

for usercond = 1:size(des_inf,2)
    for ch_nm = 1:nch
        eval(['group_ba_data.raw.across_subjects.oxy.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subjects.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
        eval(['group_ba_data.raw.across_subjects.dxy.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subjects.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
        eval(['group_ba_data.raw.across_subjects.total.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subjects.total.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);

        eval(['group_ba_data.raw.across_subxblock.oxy.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subxblock.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
        eval(['group_ba_data.raw.across_subxblock.dxy.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subxblock.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
        eval(['group_ba_data.raw.across_subxblock.total.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subxblock.total.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
    
        if get(handles.preprocessed,'value') == 1  
            eval(['group_ba_data.raw.across_subjects.oxy.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subjects.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
            eval(['group_ba_data.raw.across_subjects.dxy.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subjects.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
            eval(['group_ba_data.raw.across_subjects.total.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subjects.total.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);

            eval(['group_ba_data.raw.across_subxblock.oxy.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subxblock.oxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
            eval(['group_ba_data.raw.across_subxblock.dxy.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subxblock.dxy.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
            eval(['group_ba_data.raw.across_subxblock.total.',cond_nm{usercond},'_mean.ch',num2str(ch_nm),' = nanmean(group_ba_data.raw.across_subxblock.total.',cond_nm{usercond},'.ch',num2str(ch_nm),',2);']);
        end
    end
end
end



function [sub_ba,cond_ba] = sub_block_average(pre,pst,onset,duration,max_dur,ch_nm,subdata)
    
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
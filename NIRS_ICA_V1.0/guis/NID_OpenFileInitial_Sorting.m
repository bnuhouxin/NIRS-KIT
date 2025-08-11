function IC = NID_OpenFileInitial_Sorting(handles,IC)
%% This function calculate the evaluation metric and sort the separated sources
hb_val = get(handles.hbty,'Value');
if 1 == hb_val
    Hb = 'OXY';
elseif 2 == hb_val
    Hb = 'DXY';
elseif 3 == hb_val
    Hb = 'TOT';
end
ICA_Result = getfield(IC,Hb);
%% 
SortCheckboxTag = {'spikelike','homo','external','timetemplate','spatialtemplate'};
%% 
Selected_Rules = {};
for i = 1:length(SortCheckboxTag)
    name = SortCheckboxTag{i};
    SR_tag = findobj('Tag',name);
    val = get(SR_tag,'Value');
    if val
        if isempty(Selected_Rules)
            Selected_Rules = {name};
        else
            Selected_Rules = {Selected_Rules{:},name};
        end
    end
end
%% 
Sort.Sort_selectRule = Selected_Rules;                    %
Sort.Sort_icName = SortCheckboxTag;                       

Sort.Sort_icNum = cell(length(Sort.Sort_icName),1); % 
Sort.Sort_icValue = Sort.Sort_icNum;                % 
Sort.Sort_icName_Detail = Sort.Sort_icNum;          % 
Sort.Sort_threshold = Sort.Sort_icNum;              % 
Sort.Sort_icDetail_data = Sort.Sort_icNum;          % 
Sort.Sort_icValue_Raw = Sort.Sort_icNum;            % 
%% Noise related Components 
% Spikelike 
if ismember('spikelike',Sort.Sort_selectRule)
    [ic_num,ic_value,ic_value_raw,names,thres,data] = NID_Auto_Labeling_Motion_Artifact_Detection(handles,ICA_Result);
    [bool,inx]=ismember('spikelike',SortCheckboxTag);
    Sort.Sort_icNum{inx} = ic_num;
    Sort.Sort_icValue{inx} = ic_value;
    Sort.Sort_threshold{inx} = thres;
    Sort.Sort_icName_Detail{inx} = names;
    Sort.Sort_icDetail_data{inx} = data;
    Sort.Sort_icValue_Raw{inx} = ic_value_raw;
end

% Spatial Homo 
if ismember('homo',Sort.Sort_selectRule)
    [ic_num,ic_value,ic_value_raw,names,thres,data] = NID_Auto_Labeling_SpatialHomo(handles,ICA_Result);
    [bool,inx]=ismember('homo',SortCheckboxTag);
    Sort.Sort_icNum{inx} = ic_num;
    Sort.Sort_icValue{inx} = ic_value;
    Sort.Sort_threshold{inx} = thres;
    Sort.Sort_icName_Detail{inx} = names;
    Sort.Sort_icDetail_data{inx} = data;
    Sort.Sort_icValue_Raw{inx} = ic_value_raw;
end

% external 
if ismember('external',Sort.Sort_selectRule)
    [ic_num,ic_value,ic_value_raw,names,thres,data] = NID_Auto_Labeling_External(handles,ICA_Result);
    [bool,inx]=ismember('external',SortCheckboxTag);
    Sort.Sort_icNum{inx} = ic_num;
    Sort.Sort_icValue{inx} = ic_value;
    Sort.Sort_threshold{inx} = thres;
    Sort.Sort_icName_Detail{inx} = names;
    Sort.Sort_icDetail_data{inx} = data;
    Sort.Sort_icValue_Raw{inx} = ic_value_raw;
end
% 

%% Neural Related Components 
% evaluation and save timetemplate 
if ismember('timetemplate',Sort.Sort_selectRule)
    [ic_num,ic_value,ic_value_raw,names,thres,data] = NID_Auto_Labeling_Timetemplate(handles,ICA_Result);
    [bool,inx]=ismember('timetemplate',SortCheckboxTag);
    Sort.Sort_icNum{inx} = ic_num;
    Sort.Sort_icValue{inx} = ic_value;
    Sort.Sort_threshold{inx} = thres;
    Sort.Sort_icName_Detail{inx} = names;
    Sort.Sort_icDetail_data{inx} = data;
    Sort.Sort_icValue_Raw{inx} = ic_value_raw;
end
% evaluation and save Spatialtemplate information
if ismember('spatialtemplate',Sort.Sort_selectRule)
    [ic_num,ic_value,ic_value_raw,names,thres,data] = NID_Auto_Labeling_SpatialTemplate(handles,ICA_Result);
    [bool,inx]=ismember('spatialtemplate',SortCheckboxTag);
    Sort.Sort_icNum{inx} = ic_num;
    Sort.Sort_icValue{inx} = ic_value;
    Sort.Sort_threshold{inx} = thres;
    Sort.Sort_icName_Detail{inx} = names;
    Sort.Sort_icDetail_data{inx} = data;
    Sort.Sort_icValue_Raw{inx} = ic_value_raw;
end
%%
ICA_Result.Sort = Sort;
% oxy
if 1 == hb_val
    IC.OXY = ICA_Result;
end
%dxy
if 2 == hb_val
    IC.DXY = ICA_Result;
end
%tot
if 3 == hb_val
    IC.TOT = ICA_Result;
end
end

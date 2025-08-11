function [selectIC,muti_labelIC,labelIC,selectIC_R,muti_labelIC_R,labelIC_R] = NID_caculate_UserSelect_IC(handles)
%%
% This function get selected ICs 
% 
%% 
dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
IC = dataIn.IC;
hb_type = dataIn.hbType;
ic_struct = getfield(IC,hb_type);
sort_ic = ic_struct.Sort;
%% for noise reduction
selectIC = [];              % 
muti_labelIC = [];          % 
labelIC = {};               %  
% for extract source of interest
selectIC_R = [];            %  
muti_labelIC_R = [];        %  
labelIC_R = {};             % 

% spikelike homo external timeTemplate spatialTemplate 
if isempty(sort_ic)
    select_rule = {};
else
    select_rule = sort_ic.Sort_selectRule;
end
num_all = cellfun(@(x)find(strcmp(sort_ic.Sort_icName,x)),select_rule);

num = num_all(find(num_all<=3));            % 
num1 = num_all(find(num_all>3));            % 
%% ic to be remove
for i = 1:length(num)
    s_ic = [];
    if length(sort_ic.Sort_icName_Detail{num(i)})>1
        detailname = sort_ic.Sort_icName_Detail{num(i)};
        thres = sort_ic.Sort_threshold{num(i)};
        s_icnum = sort_ic.Sort_icNum{num(i)};
        s_icvalue = sort_ic.Sort_icValue{num(i)};
        s_ic1 = {};
        for j = 1:length(detailname)
            thres1 = thres{j};
            s_icnum1 = s_icnum{j};
            s_icvalue1 = s_icvalue{j};
            %
            s_ic1{j} = s_icnum1(find(s_icvalue1>thres1));
            s_ic = union(s_ic,s_ic1{j});
        end
        labelIC{num(i)} = s_ic;
    else
        thres = sort_ic.Sort_threshold{num(i)}{:};
        s_icnum = sort_ic.Sort_icNum{num(i)}{:};
        s_icvalue = sort_ic.Sort_icValue{num(i)}{:};
        %
        s_ic = s_icnum(find(s_icvalue>thres));
        labelIC{num(i)} = s_ic;
        
    end
    selectIC = union(selectIC,s_ic);
end
% find "multi_labelIC"
if length(num)==1
    muti_labelIC = [];
else
    multiic = [];
    muti_labelIC = [];
    for i =1:length(num)-1
        for j = (i+1):length(num)
            multiic = intersect(labelIC{num(i)},labelIC{num(j)});
            muti_labelIC = union(muti_labelIC,multiic);
        end    
    end
end

selectIC = selectIC';
%% ic to be reserve
for i = 1:length(num1)
    s_ic = [];
    if length(sort_ic.Sort_icName_Detail{num1(i)})>1
        detailname = sort_ic.Sort_icName_Detail{num1(i)};
        thres = sort_ic.Sort_threshold{num1(i)};
        s_icnum = sort_ic.Sort_icNum{num1(i)};
        s_icvalue = sort_ic.Sort_icValue{num1(i)};
        s_ic1 = {};
        for j = 1:length(detailname)
            thres1 = thres{j};
            s_icnum1 = s_icnum{j};
            s_icvalue1 = s_icvalue{j};
            %
            s_ic1{j} = s_icnum1(find(s_icvalue1>thres1));
            s_ic = union(s_ic,s_ic1{j});
        end
        labelIC_R{num1(i)} = s_ic;
    else
        thres = sort_ic.Sort_threshold{num1(i)}{:};
        s_icnum = sort_ic.Sort_icNum{num1(i)}{:};
        s_icvalue = sort_ic.Sort_icValue{num1(i)}{:};
        %
        s_ic = s_icnum(find(s_icvalue>thres));
        labelIC_R{num1(i)} = s_ic;
        
    end
    selectIC_R = union(selectIC_R,s_ic);  
end

% find "multi_labelIC"
if length(num1)==1
    muti_labelIC_R = [];
else
    multiic_R = [];
    muti_labelIC_R = [];
    for i =1:length(num1)-1
        for j = (i+1):length(num1)
            multiic_R = intersect(labelIC_R{num1(i)},labelIC_R{num1(j)});
            muti_labelIC_R = union(muti_labelIC_R,multiic_R);
        end    
    end
end

selectIC_R = selectIC_R';
end
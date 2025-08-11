function order = NID_caculate_DisplayOrder(Sort_struct,NumSort,ic_interest,IC_data)
%% this script calculation displaying order of the separated sources (espatially multi metrics is selected for evaluation the sources)
% icnum = Sort_struct.numIC;
icnum = IC_data.numIC;
order = [1:icnum];
numSort = [];
% get "active" selected rule
for i = 1:length(NumSort)
    tag = Sort_struct.Sort_icName{NumSort(i)};
%     tag = strcat('sort_',tag);
    obj = findobj('Tag',tag);
    tmp = get(obj,'Value');  
    if 1 == tmp
        numSort = [numSort,NumSort(i)];
    end
end

%
if isempty(numSort)
    % plot base on NO. of ICs
    tmp = setdiff(order,ic_interest.selectIC);
    if isrow(tmp)
        order = [ic_interest.selectIC,tmp];
    else
        order = [ic_interest.selectIC',tmp];
    end
else
    if 1 == length(numSort)
        tmp = Sort_struct.Sort_icNum{numSort(1)};
        % one dimension
        if length(tmp) == 1
            order = tmp{:};
            ic_val = Sort_struct.Sort_icValue{numSort(1)}{:};
        else
            detail_num = tmp;
            detail_value = Sort_struct.Sort_icValue{numSort(1)};
            % mean val
            order = detail_num{1};
            ic_val = detail_value{1};
            for i = 2:length(detail_num)
                rownum = detail_num{i};
                [xx,vv] = ismember(order,rownum);
                rowval = detail_value{i};
                ic_val = mean([ic_val;rowval(vv)],1);
            end
        end
        
    else
        for ii = 1:length(numSort)
            tmp1{ii} = Sort_struct.Sort_icNum{numSort(ii)};
            tmp2{ii} = Sort_struct.Sort_icValue{numSort(ii)};
        end
        % resize
        temp1 = [];
        temp2 = [];
        for i = 1:length(tmp1)
            [a,b] = size(tmp1{i});
            if b == 1
                temp1 = [temp1;tmp1{i}{:}];
                temp2 = [temp2;tmp2{i}{:}];
            else
                for j = 1:b
                    temp1 = [temp1;tmp1{i}{j}];
                    temp2 = [temp2;tmp2{i}{j}];
                end
            end
        end
        % Caculate New Value and order of displaying
        % we uesed the "normalized value" to caculate order!
        order = temp1(1,:);
        ic_val = temp2(1,:)/max(temp2(1,:));
        [a,b] = size(temp1);
        for i = 1:a
            rownum = temp1(i,:);
            [xx,vv] = ismember(order,rownum);
            rowval = temp2(i,:)/max(temp2(1,:));
            ic_val = mean([ic_val;rowval(vv)],1);
        end
        
    end
    %
    [xx,vv] = sort(ic_val,'descend');
    ic_val = xx;
    order = order(vv);
    [tmp3,tmp4] = ismember(ic_interest.selectIC,order);
    % unselect
    unselect_val = ic_val;
    unselect_val(tmp4) = [];
    unselect = order;
    unselect(tmp4) = [];
    % select
    select_val =  ic_val(tmp4);
    select = order(tmp4);
    [xx,vv] = sort(select_val,'descend');
    select_val = xx;
    select = select(vv);
    %
    if size(select,1)>1
        select = select';
        select_val = select_val';
    end
    if size(unselect,1)>1
        unselect = unselect';
        unselect_val = unselect_val';
    end
    %
    order = [select,unselect];
    ic_val = [select_val,unselect_val];
end

end
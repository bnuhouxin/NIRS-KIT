function NK_ind2grp

% This function allows user to integrate all individuals' indexdata 
% to a single table

inpath = uigetdir(pwd,'Select folder contains all subjcets'' individual-level results');

if ischar(inpath)
    sublist_mat = dir(fullfile(inpath,'*.mat'));
    sublist_txt = dir(fullfile(inpath,'*.txt'));

    if ~isempty(sublist_mat)
        sublist = sublist_mat;
        subtype = 1;
    elseif ~isempty(sublist_txt)
        sublist = sublist_txt;
        subtype = 2;
    end

    if ~isempty(sublist)
        nsub = size(sublist,1);
        all_nm = {}; all_ind = [];
        
        for subid = 1:nsub
            if isempty(all_nm)
                all_nm{1} = sublist(subid).name(1:end-4);
            else
                all_nm = vertcat(all_nm,sublist(subid).name(1:end-4));
            end
            
            if subtype == 1
                load(fullfile(inpath,sublist(subid).name));
                sub_index = indexdata.index;
            elseif subtype == 2
                indexdata = load(fullfile(inpath,sublist(subid).name));
                sub_index = indexdata(:)';
            end
        
            all_ind = [all_ind;sub_index];
        end
        
        group_inds = table(all_nm,all_ind,'VariableNames',{'subname';'indexdata'});
        
        % save 
        [file,path] = uiputfile('group_inds.mat','Save File');
        save(fullfile(path,file),'group_inds');

    end

end


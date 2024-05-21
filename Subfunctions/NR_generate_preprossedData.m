function NR_generate_preprossedData(handles)
    % generate preprocess set
    preprocessSet = NR_generate_preprossSet_view(handles);
    % for oxy
    step={};  
    for i=1:length(preprocessSet)
        
        if size(preprocessSet{i},2) == 1  % for customized function
            step{i} = ['nirsdata=',preprocessSet{i}{1},'(','nirsdata',');'];
        else
            step{i}=['nirsdata=',preprocessSet{i}{1},'(','nirsdata',','];
            for j=2:length(preprocessSet{i})-1
                step{i}=[step{i},preprocessSet{i}{j},','];
            end
            step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},');'];
        end
       
    end
    % do preprocess
    data = get(handles.axestimeseries,'UserData');
    nirsdata = data.raw;
    for j=1:length(step)
        eval(step{j});
        nirsdata.preprocessSet=preprocessSet(1:j);
    end
    data.preprocessed = nirsdata;
    data.leftseg = 0;     data.rightseg = 0;
    if get(handles.step_segment,'value') ~= 6
        data.leftseg = str2num(get(handles.leftseg,'string'));
        data.rightseg = str2num(get(handles.rightseg,'string'));
    end
    set(handles.axestimeseries,'UserData',data);
end
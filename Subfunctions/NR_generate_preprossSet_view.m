function preprocessSet = NR_generate_preprossSet_view(handles)

% generate_prepross set for dataviewer's preprocess

if get(handles.step_segment,'value') ~= 6
    preprocessSet{get(handles.step_segment,'value')} = {'NR_segment',get(handles.leftseg,'string'),get(handles.rightseg,'string')};
end

if get(handles.step_detrend,'value') ~= 6
    preprocessSet{get(handles.step_detrend,'value')} = {'NR_detrend',get(handles.order,'string')};
end

if get(handles.step_motioncorrection,'value') ~= 6
    preprocessSet{get(handles.step_motioncorrection,'value')} = {'NR_motioncorrection',num2str(get(handles.method_mc,'value'))};
end

if get(handles.step_filter,'value') ~= 6
    filt_method = get(handles.filt_method,'value');
    filt_param = get(handles.filt_method,'userdata');
    hpf = get(handles.bandlow,'string');
    lpf = get(handles.bandhigh,'string');
    if isempty(hpf)
        hpf = '''''';
    end
    
    if isempty(lpf)
        lpf = '''''';
    end

    preprocessSet{get(handles.step_filter,'value')} = {'NR_filter',num2str(filt_method),cell2mat(filt_param(1)),cell2mat(filt_param(2)),...
        hpf,lpf};
end

if get(handles.step_custom,'value') ~= 6
    funname = get(handles.custom_name_box,'string');
    preprocessSet{get(handles.step_custom,'value')} = {funname};
end


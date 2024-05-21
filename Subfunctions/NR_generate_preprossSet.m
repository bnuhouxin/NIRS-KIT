function preprocessSet = NR_generate_preprossSet(handles)

% generate preprocess set

if get(handles.step_segment,'value') ~= 8
    preprocessSet{get(handles.step_segment,'value')} = {'NR_segment',get(handles.leftseg,'string'),get(handles.rightseg,'string')};
end

if get(handles.step_detrend,'value') ~= 8
    preprocessSet{get(handles.step_detrend,'value')} = {'NR_detrend',get(handles.order,'string')};
end

if get(handles.step_motioncorrection,'value') ~= 8
    preprocessSet{get(handles.step_motioncorrection,'value')} = {'NR_motioncorrection',num2str(get(handles.method_mc,'value'))};
end

if get(handles.step_filter,'value') ~= 8
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

if get(handles.step_downsample,'value') ~= 8
    preprocessSet{get(handles.step_downsample,'value')} = {'NR_resample',get(handles.newT,'string')};
end

if get(handles.step_regress,'value') ~= 8
    preprocessSet{get(handles.step_regress,'value')} = {'NR_regress',['''',get(handles.regressor_path,'string'),''''],'subid'};
end

if get(handles.step_custom,'value') ~= 8
    funname = get(handles.custom_name_box,'string');
    preprocessSet{get(handles.step_custom,'value')} = {funname};
end
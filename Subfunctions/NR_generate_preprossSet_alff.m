function preprocessSet = NR_generate_preprossSet_alff(handles)

% generate preprocess set for alff analysis

if get(handles.step_segment,'value') ~= 4
    preprocessSet{get(handles.step_segment,'value')} = {'NR_segment',get(handles.leftseg,'string'),get(handles.rightseg,'string')};
end
if get(handles.step_detrend,'value') ~= 4
    preprocessSet{get(handles.step_detrend,'value')} = {'NR_detrend',get(handles.order,'string')};
end
if get(handles.step_downsample,'value') ~= 4
    preprocessSet{get(handles.step_downsample,'value')} = {'NR_resample',get(handles.newT,'string')};
end
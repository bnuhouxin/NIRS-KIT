function NR_load_preprossSet(preprocessSet,handles)

% load prepross set

for i = 1:length(preprocessSet)
    if strcmp(preprocessSet{i}{1},'NR_segment')
        set(handles.step_segment,'value',i);
        set(handles.leftseg,'string',preprocessSet{i}{3});
        set(handles.rightseg,'string',preprocessSet{i}{4});
    end
    if strcmp(preprocessSet{i}{1},'NR_detrend')
        set(handles.step_detrend,'value',i);
        set(handles.order,'string',preprocessSet{i}{2});
    end
    if strcmp(preprocessSet{i}{1},'NR_bandpassfilter')
        set(handles.step_bandpassfilter,'value',i);
        set(handles.bandlow,'string',preprocessSet{i}{3});
        set(handles.bandhigh,'string',preprocessSet{i}{4});
    end
    if strcmp(preprocessSet{i}{1},'NR_resample')
        set(handles.step_downsample,'value',i);
        set(handles.newT,'string',preprocessSet{i}{3});
    end
end
function handles_buttons = NR_buttons_create(HandleParent, Handles, LeftbottomPositon,  ButtonSize, requestFcn)
%%    
    %layout
    handles_buttons=[];
    for i= 1:size(LeftbottomPositon,1) 
        pbh = uicontrol(HandleParent,'Style','pushbutton',...
                    'Units','normalize',...
                    'String',num2str(i),...
                    'Position',[LeftbottomPositon(i,1),LeftbottomPositon(i,2), ButtonSize(1),ButtonSize(2)]);
        handles_buttons=[handles_buttons,pbh];
    end
    
    %fcn connect
    data = get(Handles.axestimeseries,'userdata');
    
    viwer_name = get(Handles.viewer,'name');

    for i=1:length(handles_buttons)
        set(handles_buttons(i),'Callback', {requestFcn,Handles,handles_buttons,i,'leftclick'},'BackgroundColor',[0.941,0.941,0.941]);
        if ~strcmp(viwer_name,'NIRS_KIT_BlockAverage')
            set(handles_buttons(i),'ButtonDownFcn', {requestFcn,Handles,handles_buttons,i,'rightclick'});
        end
        if isfield(data.raw,'exception_channel')
            if data.raw.exception_channel(i) == 1
                set(handles_buttons(i), 'ForegroundColor',[0.753,0.753,0.753]);
            else
                set(handles_buttons(i), 'ForegroundColor',[0,0,0]);
            end
        end
    end
    
    set(HandleParent,'userdata',handles_buttons);
    
end
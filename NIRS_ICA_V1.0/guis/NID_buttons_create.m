function handles_buttons = NID_buttons_create(HandleParent, Handles, LeftbottomPositon,  ButtonSize, requestFcn)
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
    for i=1:length(handles_buttons)
        set(handles_buttons(i),'Callback', {requestFcn,Handles,handles_buttons,i},'BackgroundColor',[0.941,0.941,0.941]);
    end
    set(HandleParent,'userdata',handles_buttons);
    
%%    
    % all clear button
%     pbh = uicontrol(HandleParent,'Style','pushbutton',...
%                 'Units','normalize',...
%                 'String','All',...
%                 'Position',[AllClearbottomPosition(1,1),AllClearbottomPosition(1,2)-0.05, ButtonSize(1)*1.5,ButtonSize(2)*1.2]);
%     set(pbh,'Callback', {requestFcn1,Handles,handles_buttons},'BackgroundColor',[0.941,0.941,0.941]);
%     handles_buttons=[handles_buttons,pbh];
%     pbh = uicontrol(HandleParent,'Style','pushbutton',...
%                 'Units','normalize',...
%                 'String','Clear',...
%                 'Position',[AllClearbottomPosition(2,1),AllClearbottomPosition(2,2)-0.05, ButtonSize(1)*1.5,ButtonSize(2)*1.2]);
%     set(pbh,'Callback', {requestFcn2,Handles,handles_buttons},'BackgroundColor',[0.941,0.941,0.941]);
%     handles_buttons=[handles_buttons,pbh];
    
end



function NID_open_file_Initial(handles)
%% initialize parameter in "NIRS_ICA_Denoiser_open_file_and_ICA_config"
% 
% FastICA Parameter Setting
% set(handles.hbty,'Enable','on','Max',3,'Min',1,'Value',1);

%%if user specified component number, then does not change

if get(handles.ic_num_caculate,'Value') == 2
else
    icNum = NID_ic_NO_caculate(handles,0.99);
    str = [];
    if 1 == get(handles.hbty,'Value')
        str = num2str(icNum.oxy);
    elseif 2 == get(handles.hbty,'Value')
        str = num2str(icNum.dxy);
    elseif 3 == get(handles.hbty,'Value')
        str = num2str(icNum.total);
    end
    
    set(handles.icnum,'String',str,'Enable','off','Userdata',icNum);
    
end
%
set(handles.advance,'Enable','on');



% ap.advance_ica_alg = 'FastICA';
% ap.advance_p1 = 2;    % deflation
% ap.advance_p2 = '10000';
% ap.advance_p3 = 4;    % skew
% ap.advance_p4 = '0.00001';
% set(handles.advance,'UserData',ap);

% Rules of Extracting Interested ICs Automaticly
set(handles.edit3,'String','');
set(handles.spikelike,'Value',0);
set(handles.homo,'Value',0);
set(handles.external,'Value',0);
%
set(handles.timetemplate,'Value',0);
set(handles.spatialtemplate,'Value',0);
end
function NID_open_file_Initial_input_icdata(handles)
%% initialize parameter in "NIRS_ICA_Denoiser_open_file_and_ICA_config"
% ����������ΪICA�������������ʱʹ��
dataIn  = get(handles.NIRS_ICA_Denoiser_open_file_and_ICA_config,'UserData');
hbtype = dataIn.hbType;
% ��ȡIC����
ic_data = dataIn.IC;
ic_data = getfield(ic_data,hbtype);
numIC =  ic_data.numIC;
%
if strcmp(hbtype,'OXY')
    set(handles.hbty,'Enable','off','Max',3,'Min',1,'Value',1);
elseif strcmp(hbtype,'DXY')
    set(handles.hbty,'Enable','off','Max',3,'Min',1,'Value',2);
elseif strcmp(hbtype,'TOT')
    set(handles.hbty,'Enable','off','Max',3,'Min',1,'Value',3);
end
% ͳһicNum��ʽ
icNum.oxy = numIC;
icNum.dxy = numIC;
icNum.total = numIC;

set(handles.ic_num_caculate,'Enable','off','Value',1,'Userdata',1); 

str = num2str(icNum.oxy);
set(handles.icnum,'String',str,'Enable','off','Userdata',icNum);
%
set(handles.advance,'Enable','off');
ap.advance_p1 = 2;   % deflation
ap.advance_p2 = '10000';
ap.advance_p3 = 1;   % pow3
ap.advance_p4 = '0.00001';
set(handles.advance,'UserData',ap);

% Rules of Extracting Intrested ICs Automaticly
% set(handles.spikelike,'Value',0);
% set(handles.homo,'Value',0);
% set(handles.external,'Value',0);
% %
% set(handles.timetemplate,'Value',0);
% set(handles.spatialtemplate,'Value',0);
end
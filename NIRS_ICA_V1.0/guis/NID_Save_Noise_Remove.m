function [outputArg1,outputArg2] = NID_Save_Noise_Remove(handles)
%NID_SAVE_NOISE_REMOVE Summary of this function goes here
%   Detailed explanation goes here

% save data path
outpath = get(handles.edit7,'String');
subfiln=get(handles.listbox1,'string');
subid=get(handles.listbox1,'value');

%
icremove = str2num(get(handles.edit3,'String'));
%
obj = findobj('Tag','NIRS_ICA_Denoiser');

NIDhandles = guihandles(obj);
data = get(NIDhandles.NIRS_ICA_Denoiser,'Userdata');
hbtype = data.hbType;
raw_nirsdata = data.nirs_data;
raw_icdata = data.IC;
icdata = getfield(raw_icdata,hbtype);
% reconstruct cleaned nirs signals
ic = icdata.TC;
A = icdata.SM;
Anew = A;
Anew(:,icremove) = 0;
nirsdata = ic*Anew'+repmat(icdata.m_rawdata,[size(ic,1),1]);

if strcmp(hbtype,'OXY')
    raw_nirsdata.oxyData = nirsdata;
elseif strcmp(hbtype,'DXY')
    raw_nirsdata.dxyData = nirsdata;
elseif strcmp(hbtype,'TOT')
    raw_nirsdata.totalData = nirsdata;
end
%
% ICA_Method.hbtype = hbtype;
% ICA_Method.A = A;
% ICA_Method.ic_timeSerials = ic;
% ICA_Method.selected_icnum = icremove;
% 
% raw_nirsdata.ICA_Method = ICA_Method;



%%print report
% obj=findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
% NIDC_handles=guihandles(obj);
% newtline = [];
% i=1;
% newtline{i} = '--------------BSS parameters------------';i=i+1;
% newtline{i} = ['Hb type:' hbtype];i=i+1;
% %if preprocessed 
% if isfield(NIDC_handles.advance.UserData,'preprocessSet')
%     newtline{i} = '--------preprocessing:';i=i+1;
%     for j=1:length(NIDC_handles.advance.UserData.preprocessSet)
%         switch NIDC_handles.advance.UserData.preprocessSet{j}{1}
%             case 'NID_segment'
%                 newtline{i} = ['Remove: first:' NIDC_handles.advance.UserData.preprocessSet{j}{2} ',last:' NIDC_handles.advance.UserData.preprocessSet{j}{3}];
%             case 'NID_detrend'
%                 newtline{i} = ['Detrend: ' NIDC_handles.advance.UserData.preprocessSet{j}{2} '-order'];
%             case 'NID_bandpassfilter'
%                 newtline{i} = ['Bandpass filtering: low:' NIDC_handles.advance.UserData.preprocessSet{j}{2} ',high:' NIDC_handles.advance.UserData.preprocessSet{j}{3}];
%             case 'NID_resample'
%                 newtline{i} = ['Resample T: ' NIDC_handles.advance.UserData.preprocessSet{j}{2}];
%         end
%         i=i+1;
%     end
% else
%     newtline{i} = 'preprocessing: none';i=i+1;
% end
% %BSS parameters
% newtline{i} = ['Algorithm: ' NIDC_handles.advance.UserData.advance_ica_alg];i=i+1;
% %if other parameters,like the approximation function in FastICA
% newtline{i} = ['Number of Sources: ' num2str(NIDhandles.NIRS_ICA_Denoiser.UserData.IC.OXY.numIC)];i=i+1;
% newtline{i} = ['Number of Removed sources: ' num2str(length(icremove))];i=i+1;
% 
% %Source evaluation metrics
% newtline{i} = '----------Evaluation metrics------------';i=i+1;
% 
% if ~isempty(icdata.Sort.Sort_selectRule)
% %     for j=1:length(icremove)
%         newtline{i} = ['Source number: ' num2str(icremove)];i=i+1;
% %     end
%     for j=1:length(icdata.Sort.Sort_selectRule)
%         newtline{i} = [icdata.Sort.Sort_selectRule{j} ':' num2str(icdata.Sort.Sort_icValue{j}{1}(icremove))];i=i+1;
%     end
% end
% 
% %write new file
% outpath_rep=[outpath(1:(find(outpath=='.')-1)) '_report'];
% h = fopen(outpath_rep,'w+');
% for j=1:1:i-1
%     fprintf(h,'%s\n',newtline{j});
% end
% fclose(h);

% save
dataout.nirsdata = raw_nirsdata;
dataout.IC = data.IC;
dataout.IC.selectedic=icremove;
save([outpath filesep subfiln{subid} '_c'],'-struct','dataout')
disp('Successfully saved!')
end


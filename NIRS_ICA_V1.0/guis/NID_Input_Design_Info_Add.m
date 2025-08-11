function NID_Input_Design_Info_Add(handles,inputData)
%% NID Handles
obj = findobj('Tag','NIRS_ICA_Denoiser');
NIDHandles = guihandles(obj);
datapath = get(NIDHandles.listbox1,'UserData');
data = load(datapath);
nirsdata = data.nirsdata;
dataLength = size(nirsdata.oxyData,1);
%% design info
if isa(inputData{3},'char')   
    timeOn = str2num(inputData{3});
    timeDu = str2num(inputData{4});
else
    timeOn = inputData{3};
    timeDu = inputData{4};
end
% 
if ~isempty(timeDu)&&~isempty(timeOn)
    if timeOn(end)+timeDu(end) > dataLength || timeDu(end) > dataLength
        errordlg('out of range');
        return;
    end
elseif ~isempty(timeOn)&&isempty(timeDu)
    if timeOn(end) > dataLength
        errordlg('out of range');
        return;
    elseif any(timeOn<0)||any(timeDu<0)
        errordlg('Invalid Input...');
        return;
    end
elseif isempty(timeOn)
    errordlg('Onset time cannot be empty...');
    return;
end
%%
    ndesign = length(timeOn);
    design = zeros(1,dataLength);
    if ~isempty(timeDu) && timeDu(1) > 0  % block design
        if length(timeDu) == 1 && timeDu ~= 0
            timeDu = ones(1,ndesign)*timeDu;
        end
        for i = 1:ndesign
            design(timeOn(i):timeOn(i)+timeDu(i)) = ones(1,timeDu(i)+1);
        end
    else
        if isempty(timeDu) || timeDu == 0  % Event-related design
            for i = 1:ndesign
                design(timeOn(i)) = 1;
            end
        end
    end
%% Preview
% -----hrf-----%
design_hrf = NID_Input_Design_Info_creat_DesignBlock(handles,timeOn,timeDu);
% design_hrf = zeros();
% for i = 1:length(timeOn)
%     design_hrf(timeOn(i):timeOn(i) + timeDu(i)) = 1;
% end

%% save data
name_now = inputData{1};
if isa(inputData{2},'char')
    thres_now = str2num(inputData{2});
else
    thres_now = inputData{2};
end
%
tableData = get(handles.uitable1,'Data');
table_info = get(handles.uitable1,'Userdata');
designData = get(handles.preview,'Userdata');
durData = get(handles.duration,'Userdata');
onsetData = get(handles.onset,'Userdata');

% row_of_table_old = table_info.row;
if ~isfield(table_info,'row')
    row_of_table_new = 1;
    tableData{1,1} = name_now;
    tableData{1,2} = thres_now;
    designData{1} = design_hrf;
    durData{1} = timeDu;
    onsetData{1} = timeOn;
else
    row_of_table_new = table_info.row+1;
    tableData{row_of_table_new,1} = name_now;
    tableData{row_of_table_new,2} = thres_now;
    designData{row_of_table_new} = design_hrf;
    durData{row_of_table_new} = timeDu;
    onsetData{row_of_table_new} = timeOn;
end
%
table_info.row = row_of_table_new;
table_info.select = row_of_table_new;

set(handles.preview,'Userdata',designData);
set(handles.uitable1,'Data',tableData,'Userdata',table_info)
%
set(handles.onset,'String',sprintf('%.0f ' , timeOn),'Userdata',onsetData);
set(handles.duration,'String',sprintf('%.0f ' , timeDu),'Userdata',durData);
end
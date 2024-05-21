function NK_3D_Registration(handles)
 % spatial registration to get MNI coordinates for channels and/or optodes
 % two method can be used
 % 1) NFRI-based registration by Dan et al., 2015
 % 2) TBA-based registration
 
 ref_path = get(handles.ref_file_listbox,'userdata');
 ch_path = get(handles.ch_file_listbox,'userdata');
 ref_fileList = get(handles.ref_file_listbox,'string');
 ch_fileList = get(handles.ch_file_listbox,'string');
 
 outpath = get(handles.out_path,'string');
 
 out_mni_path=fullfile(outpath,'MNI_Coordinates');
 out_label_path=fullfile(outpath,'Anatomical_Label');
 if ~exist(out_mni_path)
     mkdir(out_mni_path);
 end
 if ~exist(out_label_path)
     mkdir(out_label_path);
 end
 
 reg_method = get(handles.reg_method_box,'value')
 isReferCheck = get(handles.isReferCheck,'value');
 
 h=waitbar(0,'Please wait ... ...');
 
 for subid = 1:size(ref_fileList,1)
     Origin = fullfile(ref_path,ref_fileList{subid});
     Others = fullfile(ch_path,ch_fileList{subid});
     
     file_name = ch_fileList{subid}(1:end-4);
     
     waitbar((subid-0.5)/size(ref_fileList,1),h);
     
     if reg_method == 1
         [ch_label,ch_mni] = nfri_mni_estimation_KIT(Origin, Others,isReferCheck);  
         
         ch_data{1} = ch_label; ch_data{2} = ch_mni;
         save(fullfile(out_mni_path,file_name),'ch_data');
         save_mni_txt(ch_data, fullfile(out_mni_path,[file_name,'.txt']));

         nfri_anatomlabel_KIT(ch_data, fullfile(out_label_path,file_name), 10);
     elseif reg_method == 2
         [ch_label,atlas_label,ch_mni]= TBA_mni_estimation_KIT(Origin, Others);
         ch_data{1} = ch_label; ch_data{2} = ch_mni;
         
         save(fullfile(out_mni_path,file_name),'ch_data');
         save_mni_txt(ch_data, fullfile(out_mni_path,[file_name,'.txt']));
         
         save_label_csv(out_label_path,file_name,ch_data,atlas_label);
     end
     
     waitbar(subid/size(ref_fileList,1),h);
     
     disp(['-------------- sub',num2str(subid),' -------------- 3D Spatitial Registration -------------- completed!']);
     
 end
 
 waitbar(1,h);
 delete(h);
 
 msgbox('Spatial  Conversion Completed !','Success','help');
 
 
function save_mni_txt(ch_data, file_name)

fileID = fopen(file_name,'w');

tile_str = 'ID x y z';
fprintf(fileID, '%s\r\n', tile_str);
for id = 1:size(ch_data{1},1)
fprintf(fileID, '%s %4.2f %4.2f %4.2f\n',ch_data{1,1}{id}, ch_data{1,2}(id,:));
end

fclose(fileID);

function save_label_csv(out_label_path,file_name,ch_data,atlas_label)

ch_labels.BA = ch_data{1,1};
ch_labels.BA = [ch_labels.BA,num2cell(ch_data{1,2})];
ch_labels.BA = [ch_labels.BA, atlas_label.BA_Name(atlas_label.BA)];
ch_labels.BA = [ch_labels.BA, num2cell(atlas_label.BA_Prob)];
ch_labels.BA = [{'ID','X','Y','Z','Label','Probability'};ch_labels.BA];

cell2csv(fullfile(out_label_path,[file_name,'_brodmann.csv']),ch_labels.BA);

ch_labels.AAL = ch_data{1,1};
ch_labels.AAL = [ch_labels.AAL,num2cell(ch_data{1,2})];
ch_labels.AAL = [ch_labels.AAL, atlas_label.AAL_Name(atlas_label.AAL)];
ch_labels.AAL = [ch_labels.AAL, num2cell(atlas_label.AAL_Prob)];
ch_labels.AAL = [{'ID','X','Y','Z','Label','Probability'};ch_labels.AAL];

cell2csv(fullfile(out_label_path,[file_name,'_aal.csv']),ch_labels.AAL);

ch_labels.LPBA = ch_data{1,1};
ch_labels.LPBA = [ch_labels.LPBA,num2cell(ch_data{1,2})];
ch_labels.LPBA = [ch_labels.LPBA, atlas_label.LPBA_Name(atlas_label.LPBA)];
ch_labels.LPBA = [ch_labels.LPBA, num2cell(atlas_label.LPBA_Prob)];
ch_labels.LPBA = [{'ID','X','Y','Z','Label','Probability'};ch_labels.LPBA];

cell2csv(fullfile(out_label_path,[file_name,'_lpba40.csv']),ch_labels.LPBA);


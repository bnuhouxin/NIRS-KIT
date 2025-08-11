function nirs_data=NID_preprocess(nirs_data,preprocessSet,hbtyp_val)

% NR_preprocess do data preprocessing 
% input:
%       inpath: input data path
%       outpath: output data path
%       preprocessSet: preprocess configuration

% preprocessSet={{'NR_resample','10','20'},{'NR_segment','100','2000'},{'NR_detrend','1'},{'NR_bandpassfilter','10','0.01','0.08'}};



% generate preprocess code
h_wait = waitbar(0, 'Please wait... ');
% switch hbtyp_val
%     case 1
step={};  % for oxy
for i=1:length(preprocessSet)
    step{i}=['nirs_data=',preprocessSet{i}{1},'(','nirs_data',','];
    for j=2:length(preprocessSet{i})-1
        step{i}=[step{i},preprocessSet{i}{j},','];
    end
    switch hbtyp_val
        case 1
            step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},',''oxyData'');'];
        case 2
            step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},',''dxyData'');'];
            
        case 3
            step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},',''totalData'');'];
    end
end
%         step_oxy=step;
%     case 2
%         step={}; % for dxy
%         for i=1:length(preprocessSet)
%             step{i}=['nirs_data.dxyData=',preprocessSet{i}{1},'(','nirs_data.dxyData',','];
%             for j=2:length(preprocessSet{i})-1
%                 step{i}=[step{i},preprocessSet{i}{j},','];
%             end
%             step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},',''dxyData'');'];
%         end
% %         step_dxy=step;
%     case 3
%         step={};   % for total
%         for i=1:length(preprocessSet)
%             step{i}=['nirs_data.totalData=',preprocessSet{i}{1},'(','nirs_data.totalData',','];
%             for j=2:length(preprocessSet{i})-1
%                 step{i}=[step{i},preprocessSet{i}{j},','];
%             end
%             step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},',''totalData'');'];
%         end
% %         step_txy=step;
% end
% % run preprocess code
% files = dir(fullfile(inpath,'*.mat'));
% warning off;mkdir(outpath);

% for i=1:length(files)
%     load(fullfile(inpath,char(files(i).name)));
    for j=1:length(step)
        eval(step{j});
%         mkdir(fullfile(outpath,['hb_step',num2str(j)]));
%         save(fullfile(outpath,['hb_step',num2str(j)],[files(i).name(1:end-4),'_step' num2str(j),files(i).name(end-3:end)]),'nirs_data');
    end
%     waitbar(i/length(files), h_wait, 'Data preprocessing  ... ...');
%     save(fullfile(outpath,[files(i).name(1:end-4),'_preprocessed',files(i).name(end-3:end)]),'nirs_data');
% % end
waitbar(1, h_wait, 'Data preprocess finished !');
close(h_wait);
% 
% mkdir(fullfile(outpath,'preprocessSet'));
% save(fullfile(outpath,'preprocessSet','preprocessSet'),'preprocessSet');

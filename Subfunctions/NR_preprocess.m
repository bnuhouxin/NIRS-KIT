function NR_preprocess(inpath,outpath,preprocessSet)

% NR_preprocess do data preprocessing 
% input:
%       inpath: input data path
%       outpath: output data path
%       preprocessSet: preprocess configuration

% preprocessSet={{'NR_resample','10','20'},{'NR_segment','100','2000'},{'NR_detrend','1'},{'NR_bandpassfilter','10','0.01','0.08'}};

% generate preprocess code
h_wait = waitbar(0, 'Please wait... ');
step={};  % for oxy
for i=1:length(preprocessSet)
    step{i}=['nirsdata.oxyData=',preprocessSet{i}{1},'(','nirsdata.oxyData',','];
    for j=2:length(preprocessSet{i})-1
        step{i}=[step{i},preprocessSet{i}{j},','];
    end
    step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},');'];
end
step_oxy=step;
          
step={}; % for dxy
for i=1:length(preprocessSet)
    step{i}=['nirsdata.dxyData=',preprocessSet{i}{1},'(','nirsdata.dxyData',','];
    for j=2:length(preprocessSet{i})-1
        step{i}=[step{i},preprocessSet{i}{j},','];
    end
    step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},');'];
end
step_dxy=step;

step={};   % for total
for i=1:length(preprocessSet)
    step{i}=['nirsdata.totalData=',preprocessSet{i}{1},'(','nirsdata.totalData',','];
    for j=2:length(preprocessSet{i})-1
        step{i}=[step{i},preprocessSet{i}{j},','];
    end
    step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},');'];
end
step_txy=step;


% run preprocess code
files = dir(fullfile(inpath,'*.mat'));
warning off;mkdir(outpath);

for i=1:length(files)
    load(fullfile(inpath,char(files(i).name)));
    for j=1:length(step)
        eval(step_oxy{j});eval(step_dxy{j});eval(step_txy{j});nirsdata.preprocessSet=preprocessSet(1:j);
        mkdir(fullfile(outpath,['hb_step',num2str(j)]));
        save(fullfile(outpath,['hb_step',num2str(j)],[files(i).name(1:end-4),'_step' num2str(j),files(i).name(end-3:end)]),'nirsdata');
    end
    waitbar(i/length(files), h_wait, 'Data preprocessing  ... ...');
    save(fullfile(outpath,[files(i).name(1:end-4),'_preprocessed',files(i).name(end-3:end)]),'nirsdata');
end
waitbar(1, h_wait, 'Data preprocess finished !');
close(h_wait);

mkdir(fullfile(outpath,'preprocessSet'));
save(fullfile(outpath,'preprocessSet','preprocessSet'),'preprocessSet');

function NR_Preprocessing(handles)
%% generate output file path
inpathList = get(handles.inpathList,'string');
outpath = get(handles.outpath,'string');
allfile = dir(fullfile(inpathList,'*.mat'));

warning off; mkdir(outpath);
%% preprocess for 
% generate preprocess configuration
preprocessSet = NR_generate_preprossSet(handles);

% Generate data processing command statements
step={};  % 
for i=1:length(preprocessSet)
    
    if size(preprocessSet{i},2) == 1 
        step{i} = ['nirsdata=',preprocessSet{i}{1},'(','nirsdata',');'];
    else
        step{i}=['nirsdata=',preprocessSet{i}{1},'(','nirsdata',','];
        for j=2:length(preprocessSet{i})-1
            step{i}=[step{i},preprocessSet{i}{j},','];
        end
        step{i}=[step{i},preprocessSet{i}{length(preprocessSet{i})},');'];
    end
end


% execute preprocessing
h_wait = waitbar(0, 'Preprocessing data ... ');

for subid=1:length(allfile)
    
    load(fullfile(inpathList,allfile(subid).name));
    for j=1:length(step)
        eval(step{j});
        nirsdata.preprocessSet=preprocessSet(1:j);
    end
           
    waitbar(subid/length(allfile), h_wait, 'Preprocessing data ... ...');
    save(fullfile(outpath,allfile(subid).name),'nirsdata');
end

waitbar(1, h_wait, 'Data preprocess finished !');
pause(1);
close(h_wait);
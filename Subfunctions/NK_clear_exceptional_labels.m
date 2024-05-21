function NK_clear_exceptional_labels
%

inpath = uigetdir;
if ischar(inpath)
    sublist = dir(fullfile(inpath,'*.mat'));
    
    for sub = 1:length(sublist)
        load(fullfile(inpath,sublist(1).name));
        
        if exist('nirsdata') 
            nirsdata.exception_channel = zeros(1,length(nirsdata.exception_channel));

            save(fullfile(inpath,sublist(1).name),'nirsdata');
        elseif exist('indexdata')
            indexdata.exception_channel = zeros(1,length(indexdata.exception_channel));
            
            save(fullfile(inpath,sublist(1).name),'indexdata');
        end
    end
        
end    


end
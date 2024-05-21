function Matrix_correlation(handles)
inpath = get(handles.inpath,'string');

h_wait = waitbar(0, 'Please wait... ');
% covariable
files = dir(fullfile(inpath,'*.txt'));
depVariable=[];

for i=1:length(files)
    Matrix=load(fullfile(inpath,files(i).name));
    depVariable = [depVariable;Matrix(:)'];
end

chn=size(Matrix);

% text covariable ----------------------- .txt ----------------------------
otherCovPath = get(handles.otherCovPath,'string');
otherCovariates = [];
if ~isempty(otherCovPath)
    otherCovariates = load(otherCovPath);
end

% behavioral data ----------------------- .txt ----------------------------
inpathBehav = get(handles.listTextBehavdata,'string');
BehavData = load(inpathBehav);
N = size(depVariable,2);

for i = 1:N
    
    % =============== remove the subj with exclusive channel ==============
    dep_X = depVariable(:,i);
    
    dep_X = dep_X(find(~isnan(dep_X)),:);
    beh_D = BehavData(find(~isnan(dep_X)),:);
    % =============== remove the subj with exclusive channel ==============
    
    
    if isempty(otherCovariates)
        [stat p] = corrcoef(dep_X,beh_D);
    else
        cov_V = otherCovariates(find(~isnan(dep_X)),:);
        [stat p] = partialcorr([dep_X,beh_D],cov_V);
    end
    statdata.stat(i) = stat(1,2); statdata.p(i) = p(1,2);
    
    waitbar(i/N, h_wait, 'Running correlation analysis ... ...');
end

%------------------------------Multiple comparison correction -------------
pStr=get(handles.pValue,'string');
pValue = str2num(pStr);
method = get(handles.method,'value');
% ========================== reshape vec2matrix ===========================
statdata.stat = reshape(statdata.stat,chn);
statdata.stat(1:size(statdata.stat,1)+1:end) = 0;
statdata.p = reshape(statdata.p,chn);


if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
    str_channels = get(handles.mask_channels,'string');                       %
    mask_channels = str2num(str_channels);                                    %
    statdata.mask_channels = mask_channels;                               %
    n_mask_channels = length(mask_channels);                              %
    statdata.stat=statdata.stat(mask_channels,mask_channels);             %
    statdata.p=statdata.p(mask_channels,mask_channels);  
else
    statdata.mask_channels = 1:chn;
    n_mask_channels = chn(1);
end

statdata.sig = zeros(n_mask_channels);                    %---------------%
n=n_mask_channels*(n_mask_channels-1)/2;                  %---------------%
% =========================================================================   
    switch method
            case 1
                eval(['statdata.None',pStr(3:end),'_PThrd = pValue']);
                statdata.sig(find(statdata.p <= pValue))=1;
                
                outfileName = ['correlation_None',pStr(3:end),'.mat'];
            case 2             
                eval(['statdata.FDR',pStr(3:end),'_PThrd = matrix_fdr(statdata.p,pValue)']);
                if ~isempty(matrix_fdr(statdata.p,pValue))
                    statdata.sig(find(statdata.p <= matrix_fdr(statdata.p,pValue)))=1;
                end
                
                outfileName = ['correlation_FDR',pStr(3:end),'.mat'];
            case 3
                pbrf=pValue/n;
                eval(['statdata.Bonferroni',pStr(3:end),'_PThrd = pbrf']);
                statdata.sig(find(statdata.p <= pbrf))=1;
                
                outfileName = ['correlation_Bonferroni',pStr(3:end),'.mat' ];
    end
%------------------------------Multiple comparison correction -------------
outpath = get(handles.outpath,'string');
files = dir(fullfile(outpath,'*.mat'));
    for k=1:length(files)
        if strcmp(outfileName,files(k).name)
            ifOverwrite  = questdlg('One file already exists. Overwrite?','mode seletion','Yes','No','Yes');
            if strcmp(ifOverwrite,'Yes')
                break;
            else
                return;
            end
        end
    end

% save results
warning off;mkdir(outpath);

[fn,fp]=uiputfile({'*.mat','MAT-files(*.mat)'},'Results File Name',fullfile(outpath,outfileName));
if ischar(fp)
    save(fullfile(fp,fn),'statdata');
end

waitbar(1, h_wait, 'Correlation analysis successfully done !');
pause(1);
close(h_wait);
end

function Matrix_ttest2(handles)

inpath = get(handles.listGroupImages,'string');

h_wait = waitbar(0, 'Please wait... ');
    
% dependent variable1
depVariable1=[];
files = dir(fullfile(inpath{1},'*.txt'));
for i=1:length(files)
    Matrix=load(fullfile(inpath{1},files(i).name));
    depVariable1 = [depVariable1;Matrix(:)'];
end

% dependent variable2
depVariable2=[];
files = dir(fullfile(inpath{2},'*.txt'));
for i=1:length(files)
    Matrix=load(fullfile(inpath{2},files(i).name));
    depVariable2 = [depVariable2;Matrix(:)'];
end

chn=size(Matrix);

depVariable = [depVariable1;depVariable2];

regressors=ones(size(depVariable,1),1)*-1;
regressors(1:size(depVariable1,1),1)=1;
regressors(:,2)=1;

waitbar(1/3, h_wait, 'Running Two-sample T-test ... ...');
% text covariable
inpathTextCov = get(handles.listTextCovariates,'string');

if ~isempty(inpathTextCov)
    Covariates1 = load(inpathTextCov{1});
    Covariates2 = load(inpathTextCov{2});
    Covariates = [Covariates1;Covariates2];
    regressors=[regressors,Covariates];
    
    constrast=zeros(1,size(regressors,2));
    constrast(1,1)=1;
    [Stat_T,Stat_P] =NK_Stat_Regress(depVariable,regressors,constrast,'T');
else
    constrast=zeros(1,size(regressors,2));
    constrast(1,1)=1;
    [Stat_T,Stat_P] =NK_Stat_Regress(depVariable,regressors,constrast,'T');
end

statdata.stat= Stat_T;
statdata.p = Stat_P;

statdata.discription = 'Two sample t-test';

waitbar(2/3, h_wait, 'Running Two-sample T-test ... ...');
%------------------------------Multiple comparison correction -------------
pStr=get(handles.pValue,'string');
pValue = str2num(pStr);
method = get(handles.method,'value');
% ========================== reshape vec2matrix ===========================
statdata.stat= reshape(statdata.stat,chn);
statdata.stat(1:size(statdata.stat,1)+1:end) = 0;
statdata.p = reshape(statdata.p,chn);

str_channels = get(handles.mask_channels,'string');                       %
mask_channels = str2num(str_channels);                                    %

if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
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
                
                outfileName = ['ttest2_None',pStr(3:end),'.mat'];
            case 2
                eval(['statdata.FDR',pStr(3:end),'_PThrd = matrix_fdr(statdata.p,pValue)']);

                if ~isempty(matrix_fdr(statdata.p,pValue))
                    statdata.sig(find(statdata.p <= matrix_fdr(statdata.p,pValue)))=1;
                end
              
                outfileName = ['ttest2_FDR',pStr(3:end),'.mat' ];
            case 3
                pbrf=pValue/n;
                eval(['statdata.Bonferroni',pStr(3:end),'_PThrd = pbrf']);
                statdata.sig(find(statdata.p <= pbrf))=1;

                outfileName = ['ttest2_Bonferroni',pStr(3:end),'.mat' ];
    end
% =========================================================================    
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
warning off; mkdir(outpath);

[fn,fp]=uiputfile({'*.mat','MAT-files(*.mat)'},'Results File Name',fullfile(outpath,outfileName));
if ischar(fp)
    save(fullfile(fp,fn),'statdata');
end

waitbar(1, h_wait, 'Two sample T-test successfully done !');
pause(1);
close(h_wait);
end
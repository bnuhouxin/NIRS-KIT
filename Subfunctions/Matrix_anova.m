function Matrix_anova(handles)
% dependent variable
inpath = get(handles.listGroupImages,'string');

s = length(inpath);
h_wait = waitbar(0, 'Please wait... ');

depVariable=[];
GroupLabel=[];
Covariates=[];

for i=1:s
    files = dir(fullfile(inpath{i},'*.txt'));
    for j=1:length(files)
        Matrix=load(fullfile(inpath{i},files(j).name));
        DependentFiles(j,:)=Matrix(:)';
    end
    depVariable=[depVariable;DependentFiles];
    GroupLabel=[GroupLabel;ones(size(DependentFiles,1),1)*i];
    
    clear DependentFiles;
end

Group_Var=zeros(size(depVariable,1),s-1);
for ii=1:s-1
    Group_Var(find(GroupLabel==ii),ii)=1;
end

chn=size(Matrix);

waitbar(1/3, h_wait, 'Running One-way ANOVA ... ...');


inpathOther = get(handles.listTextCovariates,'string');

if get(handles.isrepeated,'value')==0
    mname='anova';
    
    regressors=[Group_Var,ones(size(Group_Var,1),1)];
    if ~isempty(inpathOther)
        for i=1:length(inpathOther)
            ind_cov = load(inpathOther{i});
            Covariates = [Covariates;ind_cov];
        end
        regressors = [regressors,Covariates];
    end
    
    constrast = zeros(1,size(regressors,2));
    constrast(1,1:size(Group_Var,2)) = 1;
    
    [Stat_F,Stat_P] = NK_Stat_Regress(depVariable,regressors,constrast,'F');
elseif get(handles.isrepeated,'value')==1
    mname='rep_anova';
    
    num_sample = size(depVariable,1);
    nu_sub = num_sample/s;
        
    subregressors = zeros(num_sample, nu_sub);
    for i=1:nu_sub
        subregressors(i:nu_sub:num_sample,i) = 1;
    end
    
    regressors = [Group_Var,subregressors];
        
    if ~isempty(inpathOther)
        cov=load(inpathOther{1});
       
        [m,n]=size(cov);
        CovariatesMatrix=zeros(num_sample,(s-1)*n);
        for ii=1:s-1
            CovariatesMatrix((ii-1)*m+1:ii*m,(ii-1)*n+1:ii*n)=cov;
        end
        regressors = [regressors,CovariatesMatrix];
    end
    constrast = zeros(1,size(regressors,2));
    constrast(1,1:size(Group_Var,2)) = 1;
    
    [Stat_F,Stat_P] = NK_Stat_Regress(depVariable,regressors,constrast,'F');
end


statdata.stat = Stat_F;
statdata.p = Stat_P;
statdata.discription=mname;

waitbar(2/3, h_wait, 'Running One-way ANOVA ... ...');
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

if isfield(statdata,'stats')
    statdata.stats=reshape(statdata.stats,chn);
end

if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
    statdata.mask_channels = mask_channels;                               %
    n_mask_channels = length(mask_channels);                              %
    statdata.stat=statdata.stat(mask_channels,mask_channels);             %
    statdata.p=statdata.p(mask_channels,mask_channels);  
    
    if isfield(statdata,'stats')
        statdata.stats=statdata.stats(mask_channels,mask_channels);
    end
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
        
        outfileName=[mname,'_None',pStr(3:end),'.mat' ];
    case 2
        eval(['statdata.FDR',pStr(3:end),'_PThrd = matrix_fdr(statdata.p,pValue)']);
        
        if ~isempty(matrix_fdr(statdata.p,pValue))
            statdata.sig(find(statdata.p <= matrix_fdr(statdata.p,pValue)))=1;
        end
        
        outfileName=[mname,'_FDR',pStr(3:end),'.mat' ];
    case 3
        pbrf=pValue/n;
        eval(['statdata.Bonferroni',pStr(3:end),'_PThrd = pbrf']);
        statdata.sig(find(statdata.p <= pbrf))=1;
        
        outfileName=[mname,'_Bonferroni',pStr(3:end),'.mat' ];
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
%------------------------------Multiple comparison correction -------------

%save results
warning off; mkdir(outpath);

[fn,fp]=uiputfile({'*.mat','MAT-files(*.mat)'},'Results File Name',fullfile(outpath,outfileName));
if ischar(fp)
    save(fullfile(fp,fn),'statdata');
end

waitbar(1, h_wait, 'ANOVA successfully done !');
pause(1);
close(h_wait);
end

function NR_anova(handles)

inpath = get(handles.listGroupImages,'string');

s = length(inpath);
h_wait = waitbar(0, 'Please wait... ');

depVariable=[];
GroupLabel=[];
Covariates=[];

for i=1:s
    files = dir(fullfile(inpath{i},'*.mat'));
    for j=1:length(files)
        load(fullfile(inpath{i},files(j).name));
        DependentFiles(j,:)=indexdata.index;
    end
    depVariable=[depVariable;DependentFiles];
    
    GroupLabel=[GroupLabel;ones(size(DependentFiles,1),1)*i];
    clear DependentFiles;
end

Group_Var=zeros(size(depVariable,1),s-1);
for ii=1:s-1
    Group_Var(find(GroupLabel==ii),ii)=1;
end


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
statdata.stat(find(isnan(statdata.stat)==1))=0;
statdata.probe2d = indexdata.probe2d;
statdata.probe3d = indexdata.probe3d;
statdata.discription=mname;

waitbar(2/3, h_wait, 'Running One-way ANOVA ... ...');
%------------------------------Multiple comparison correction -------------
n = length(statdata.p);
pStr=get(handles.pValue,'string');
pValue = str2num(pStr);
method = get(handles.method,'value');

if isfield(indexdata,'roiCh1')
    statdata.roiCh1=indexdata.roiCh1;
end
if isfield(indexdata,'roiCh2')
    statdata.roiCh2=indexdata.roiCh2;
end

statdata.sig = zeros(1,n);

switch method
    case 1
        eval(['statdata.None',pStr(3:end),'_PThrd = pValue']);
        statdata.sig(find(statdata.p <= pValue))=1;
        
        outfileName=[mname,'_None',pStr(3:end),'.mat'];
    case 2
        str_channels = get(handles.mask_channels,'string');
        mask_channels = str2num(str_channels);
        
        if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
            statdata.mask_channels=mask_channels;
            eval(['statdata.FDR',pStr(3:end),'_PThrd = FDR(statdata.p(mask_channels),pValue)']);
            if ~isempty(FDR(statdata.p(mask_channels),pValue))
                statdata.sig(mask_channels(find(statdata.p(mask_channels) <= FDR(statdata.p(mask_channels),pValue))))=1;
            end
        else
            eval(['statdata.FDR',pStr(3:end),'_PThrd = FDR(statdata.p,pValue)']);
            if ~isempty(FDR(statdata.p,pValue))
                statdata.sig(find(statdata.p <= FDR(statdata.p,pValue)))=1;
            end
        end
        
        outfileName=[mname,'_FDR',pStr(3:end),'.mat'];
    case 3
        str_channels = get(handles.mask_channels,'string');
        mask_channels = str2num(str_channels);
        
        if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
            n_mask_channels = length(mask_channels);
            statdata.mask_channels=mask_channels;
            pbrf=pValue/n_mask_channels;
            eval(['statdata.Bonferroni',pStr(3:end),'_PThrd = pbrf']);
            statdata.sig(mask_channels(find(statdata.p(mask_channels) <= pbrf)))=1;
        else
            pbrf=pValue/length(statdata.p);
            eval(['statdata.Bonferroni',pStr(3:end),'_PThrd = pbrf']);
            statdata.sig(find(statdata.p <= pbrf))=1;
        end
        
        outfileName=[mname,'_Bonferroni',pStr(3:end),'.mat'];
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

%save results
warning off; mkdir(outpath);

[fn,fp]=uiputfile({'*.mat','MAT-files(*.mat)'},'Results File Name',fullfile(outpath,outfileName));
if ischar(fp)
    save(fullfile(fp,fn),'statdata');
end

waitbar(1, h_wait, 'One-way ANOVA successfully done !');
pause(1);
close(h_wait);
end

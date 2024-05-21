function nirs_firstlevel_analysis(handles)
% =========================================================================
%           GLM bulid && GLM estimation && Con value calculation
% =========================================================================
%%  Presetting

inpath=get(handles.addPath,'userdata');
outpath=get(handles.outpath,'string');

isoxy=get(handles.Oxy,'value');
isdxy=get(handles.Dxy,'value');
istotal=get(handles.Total,'value');

sublist=get(handles.fileList,'string');
n_sub=length(sublist);
condi_num=handles.condi_num;
%% Construct GLM and calculate beta value
if handles.inputtype==1 && condi_num > 0
    
    h1=waitbar(0,'Generate GLM & Beta Value! Please wait ... ...');
    
    load(fullfile(inpath,sublist{1}));
    T=nirsdata.T;
    nch=nirsdata.nch;
    %  step01 get design information --------------------------------------
    if get(handles.DesignType,'value')==1
        cond_name=handles.cond_name;
        cond_name=['constant',cond_name];
        for n_cond=1:condi_num
            des_inf_mtx{1,n_cond}(:,1)=handles.onset{n_cond,1};
            des_inf_mtx{1,n_cond}(:,2)=handles.dur{n_cond,1};
        end
        des_inf_mtx=repmat(des_inf_mtx,n_sub,1);
    elseif get(handles.DesignType,'value')==2
        cond_name=handles.design_inf(1,2:end);
        cond_name=['constant',cond_name];
        for subid=1:n_sub
            for n_cond=1:condi_num
                des_inf_mtx{subid,n_cond}=handles.design_inf{subid+1,n_cond+1};
            end
        end
    end
    
    % step02 reshape design inf when seconds ------------------------------
    [m,n]=size(des_inf_mtx);
    if get(handles.Units,'value')==2
        for mm=1:m
            for nn=1:n
                des_inf_mtx{mm,nn}=des_inf_mtx{mm,nn}/T;
            end
        end
    end
    
    % step03 get covariates when selected ---------------------------------
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
        cov_path = get(handles.covp_box,'string');
        cov_files = dir(fullfile(cov_path,'*.txt'));
    end
    
    % STEP01: GLM bulid && GLM estimation -----------------------------
    [hrf,~] = spm_hrf(T);
    GLM_path=fullfile(outpath,'GLM');
    if ~exist(GLM_path,'dir')
        mkdir(GLM_path);
    end
    
    for subid=1:n_sub
        load(fullfile(inpath,sublist{subid}));
        
        % generate design matrix && refrence wave =========================
        num_tp=length(nirsdata.vector_onset);
        
        desmtx=zeros(num_tp,n); refwave=[];
        for n_cond=1:n
            for n_trial=1:size(des_inf_mtx{subid,n_cond},1)
                onset_trail=des_inf_mtx{subid,n_cond}(n_trial,1);
                dur_trail=des_inf_mtx{subid,n_cond}(n_trial,2);
                desmtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
            refwave(:,n_cond)=conv(desmtx(:,n_cond),hrf);
        end
        refwave=refwave(1:num_tp,:); % delete the redundant points
        
        GLM_data.condition_number=n;              % |         GLM         |
        GLM_data.cond_name=cond_name(2:end);      % |                     |
        GLM_data.des_inf_mtx=des_inf_mtx(subid,:);% |                     |
        GLM_data.desmtx=desmtx;                   % |                     |
        GLM_data.refwave=refwave;                 % |                     |
        GLM_data.subname=sublist{subid};          % |                     |
        GLM_data.probe2d=nirsdata.probe2d;        % |                     |
        GLM_data.probe3d=nirsdata.probe3d;        % |                     |
        GLM_data.T=nirsdata.T;                    % |                     |
        GLM_data.nch=nirsdata.nch;                % |                     |
        if isfield(nirsdata,'exception_channel')
            GLM_data.exception_channel = nirsdata.exception_channel;
        else
            GLM_data.exception_channel = zeros(1,nirsdata.nch);
        end
        
        if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
            GLM_data.cov = importdata(fullfile(cov_path, cov_files(subid).name));
            if size(GLM_data.cov,1) ~= size(GLM_data.refwave,1)
                warndlg('The number of covariate time points does equal to HB data !!!');
                break;
            end
            glmpredictors = [GLM_data.refwave,GLM_data.cov];
            GLM_data.predmtx = glmpredictors;
            GLM_data.predmtx(:,end+1) = 1;
        else
            GLM_data.cov = [];
            glmpredictors = GLM_data.refwave;
            GLM_data.predmtx = glmpredictors;
            GLM_data.predmtx(:,end+1) = 1;
        end
        % =================================================================
        
        % calculate beta value ============================================
        indexdata.probe2d=nirsdata.probe2d;
        indexdata.probe3d=nirsdata.probe3d;
        indexdata.subname=sublist{subid};
        indexdata.nch = nirsdata.nch;
        if isfield(nirsdata,'exception_channel')
            indexdata.exception_channel = nirsdata.exception_channel;
        else
            indexdata.exception_channel = zeros(1,nirsdata.nch);
        end
        
        % Oxy beta --------------------------------------------------------
        if isoxy
            outsubpath=fullfile(outpath,'Oxy');
            if ~exist(outsubpath,'dir')
                mkdir(outsubpath);
            end
            
            indexdata.signal_type='Oxy';            
            for ch_id=1:nch
                beta_all(:,ch_id)=glmfit(glmpredictors,nirsdata.oxyData(:,ch_id));
            end
       
            GLM_data.beta_Oxy=beta_all;
            for beta_id=1:n+1
                indexdata.index=beta_all(beta_id,:);
                indexdata.index(indexdata.exception_channel ==1) = NaN;
                indexdata.beta_name=cond_name{beta_id};
                betapath=fullfile(outsubpath,['beta_',num2str(beta_id-1)]);
                warning off; mkdir(betapath);
                save(fullfile(betapath,sublist{subid}),'indexdata');
            end
        end
        
        % Dxy beta --------------------------------------------------------
        if isdxy
            outsubpath=fullfile(outpath,'Dxy');
            if ~exist(outsubpath,'dir')
                mkdir(outsubpath);
            end
            
            indexdata.signal_type='Dxy';
            for ch_id=1:nch
                beta_all(:,ch_id)=glmfit(glmpredictors,nirsdata.dxyData(:,ch_id));
            end
            
            beta_all(2:end,:)=beta_all(2:end,:)*-1; % Dxy beta * -1
            
            GLM_data.beta_Dxy=beta_all;
            for beta_id=1:n+1
                indexdata.index=beta_all(beta_id,:);
                indexdata.index(indexdata.exception_channel ==1) = NaN;
                indexdata.beta_name=cond_name{beta_id};
                betapath=fullfile(outsubpath,['beta_',num2str(beta_id-1)]);
                warning off; mkdir(betapath);
                save(fullfile(betapath,sublist{subid}),'indexdata');
            end
        end
        
        % Total beta ------------------------------------------------------
        if istotal
            outsubpath=fullfile(outpath,'Total');
            if ~exist(outsubpath,'dir')
                mkdir(outsubpath);
            end
            
            indexdata.signal_type='Total';
            for ch_id=1:nch
                beta_all(:,ch_id)=glmfit(glmpredictors,nirsdata.totalData(:,ch_id));
            end
            GLM_data.beta_Total=beta_all;
            for beta_id=1:n+1
                indexdata.index=beta_all(beta_id,:);
                indexdata.index(indexdata.exception_channel ==1) = NaN;
                indexdata.beta_name=cond_name{beta_id};
                betapath=fullfile(outsubpath,['beta_',num2str(beta_id-1)]);
                warning off; mkdir(betapath);
                save(fullfile(betapath,sublist{subid}),'indexdata');
            end
        end
        
        save(fullfile(GLM_path,sublist{subid}),'GLM_data');
        waitbar(subid/n_sub,h1);
    end
    close(h1);
end
%%  Contrast value calculation
if handles.contr_num > 0
    indexdata={}; %--------------------------------------------------------
    h2=waitbar(0,'Genereate Contrast Value! Please wait ... ...');
    
    if handles.inputtype==2
        GLM_path=inpath;
    else
        GLM_path=fullfile(outpath,'GLM');
    end
    
    for subid=1:n_sub
        load(fullfile(GLM_path,sublist{subid}));
        
        indexdata.probe2d=GLM_data.probe2d;
        indexdata.probe3d=GLM_data.probe3d;
        nch=GLM_data.nch;
        indexdata.subname=sublist{subid};

        for ct_id=1:handles.contr_num
            contr=eval(handles.contrs{ct_id});
            if length(contr) < condi_num
                contr(1,condi_num) = 0;
            elseif length(contr) >= condi_num
                contr = contr(1,1:condi_num);
            end
            
            indexdata.contrast=contr;
            indexdata.contrast_name=handles.cont_name{ct_id};
            if isfield(GLM_data,'beta_Oxy')
                for cd_id=1:handles.condi_num
                    for ch_id=1:nch
                        contrs_value(cd_id,ch_id)=GLM_data.beta_Oxy(cd_id+1,ch_id)*contr(cd_id);
                    end
                end
                indexdata.index=sum(contrs_value,1);
                indexdata.index(GLM_data.exception_channel == 1) = NaN;
                sub_outp=fullfile(outpath,'Oxy',['con',num2str(ct_id)]); mkdir(sub_outp);
                save(fullfile(sub_outp,sublist{subid}),'indexdata');
            end
            
            if isfield(GLM_data,'beta_Dxy')
                for cd_id=1:handles.condi_num
                    for ch_id=1:nch
                        contrs_value(cd_id,ch_id)=GLM_data.beta_Dxy(cd_id+1,ch_id)*contr(cd_id);
                    end
                end
                indexdata.index=sum(contrs_value,1);
                indexdata.index(GLM_data.exception_channel == 1) = NaN;
                sub_outp=fullfile(outpath,'Dxy',['con',num2str(ct_id)]);mkdir(sub_outp);
                save(fullfile(sub_outp,sublist{subid}),'indexdata');
            end
            
            if isfield(GLM_data,'beta_Total')
                for cd_id=1:handles.condi_num
                    for ch_id=1:nch
                        contrs_value(cd_id,ch_id)=GLM_data.beta_Total(cd_id+1,ch_id)*contr(cd_id);
                    end
                end
                indexdata.index=sum(contrs_value,1);
                indexdata.index(GLM_data.exception_channel == 1) = NaN;
                sub_outp=fullfile(outpath,'Total',['con',num2str(ct_id)]);mkdir(sub_outp);
                save(fullfile(sub_outp,sublist{subid}),'indexdata');
            end
        end
        waitbar(subid/n_sub,h2);
        
    end
    close(h2);
end

pause(0.5);
msgbox('All the work has been done!!!','Task Individual Analysis','help');
end
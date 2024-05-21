function NR_convert(handles)
inpathData = get(handles.inpathData,'string');
dataType = get(handles.datatype,'value');
isProbe2d = get(handles.isProbe2d,'value');
isProbe3d = get(handles.isProbe3d,'value');
if isProbe2d
    inpath2d = get(handles.inpath2d,'string');
    load(inpath2d);
end
if isProbe3d
    inpath3d = get(handles.inpath3d,'string');
end
outpath = get(handles.outpath,'string');
warning off;mkdir(outpath);


% Type 1: HITACHI4000 (OD, 1set, *.csv) 
% Type 2: HITACHI4000 (OD, 2set, *.csv) 
% Type 3: NIRX (OD, *.wl1 & *.wl2)
% Type 4: HITACHI4000 (HB, 1 set, *.csv)
% Type 5: HITACHI4000 (HB, 2 sets, *.csv)
% Type 6: SHIMADU LABNIRS (HB, *.txt)
% Type 7: Manual Input (OD)
% Type 8: Manual Input (HB)
% Type 9: NIRS_SPM HB (raw, *.mat)
% Type 10: NIRS_SPM HB (preprocessed, *.mat)
% Type 11: HomER2 OD (raw, *.nirs)
% Type 12: HomER2 HB (preprocessed, *.nirs)
% Type 13: HomER3 OD  (raw, *.snirf)


% Type ?: SHIMADU LABNIRS (OD, *.OMM)
% Type ?: HomER3 OD  (preprocessed, *.snirf)


dataType = dataType-1;

switch dataType
    
    % Type 1: HITACHI4000 (OD, 1set, *.csv) -------------------------------
    case 1
        files = dir(fullfile(inpathData,'*.csv'));
        h_wait = waitbar(0, 'Please wait... ');
        n = size(files,1);
        
        for sub=1:n
            subfile=fullfile(inpathData,files(sub).name);
            
            fid = fopen(subfile);

            while 1
                tline = fgetl(fid);

            % HX 20231010 data split type ---------------------------------       
                if find(tline == ',', 1) 
                    uni_str = ',';
                elseif find(tline == ' ', 1)
                    uni_str = '	';
                end
            % HX 20231010 data split type ---------------------------------

                if  contains(tline, 'Wave Length')  %reading wave lengths on each probe
                    nindex = find(tline == uni_str);
                    tline(nindex) = ' ';
                    txt_wavelength = tline(nindex(1)+1:end);
                    error_index = strfind(txt_wavelength, '..');
                    txt_wavelength(error_index) =  [];

                    remain = txt_wavelength;
                    ndata = 0;
                    wav_mat = [];
                    while 1
                        [token, remain] = strtok(remain);
                        if isempty(token) == 1
                            break;
                        end
                        sind = find(token == '(')+1;
                        eind = find(token == ')')-1;
                        wav_mat = [wav_mat str2num(token(sind:eind))];
                        ndata = ndata + 1;
                    end
                    waitbar(1/3, h_wait, 'Data reading (1/3) has been completed.');
                elseif contains(tline, 'Sampling Period[s]') % reading sampling period
                    nindex = find(tline ==  uni_str);
                    tline(nindex) = ' ';
                    txt_fs = tline(nindex(1)+1:end);
                    try
                        fs = 1./mean(str2num(txt_fs));
                    catch
                        error_index = strfind(txt_fs, '..');
                        txt_fs(error_index) = [];
                        fs = 1./mean(str2num(txt_fs));
                    end
                    waitbar(2/3, h_wait, 'Data reading (2/3) has been completed.');
                elseif contains(tline, 'Probe1') 
                    disp('Reading the data from Probe1 ...');
                    nindex = find(tline ==  uni_str);
                    txt_probe = tline(nindex(1)+1:end);
                    index_tmp = find(txt_probe == uni_str);
                    txt_probe(index_tmp) = ' ';
                    [token remain] = strtok(txt_probe);
                    count = 3;
                    while isempty(token) ~= 1
                        [token remain] = strtok(remain);
                        if strcmp(token, 'Mark') == 1
                            col_mark = count;
                        end
                        if strcmp(token, 'PreScan') == 1
                            col_prescan = count;
                        end
                        count = count + 1;
                    end
                    while 1
                        tline = fgetl(fid);
                        if ischar(tline) == 0, break, end
                        nindex = find(tline == uni_str);
                        try
                            count = str2num(tline(1:nindex(1)-1));
                            tline(nindex) = ' ';
                            try
                                mes(count, :) = str2num(tline(nindex(1)+1:nindex(ndata+1)-1));
                            catch
                                str = tline(nindex(1)+1:nindex(ndata+1)-1);
                                error_index = strfind(str, '..');
                                str(error_index) = [];
                                mes(count, :) = str2num(str);
                            end
                            try
                                baseline(count) = str2num(tline(nindex(col_prescan-1)+1:nindex(col_prescan)-1));
                            catch
                                baseline(count) = str2num(tline(nindex(col_prescan-1)+1:end));
                            end
                            try
                                vector_onset(count) = str2num(tline(nindex(col_mark-1)+1:nindex(col_mark)-1));
                            end
                        end
                    end
                    waitbar(3/3, h_wait,'Data reading (3/3) has been completed.');
                    disp('Completed.');
                    break,
                end
            end
            fclose(fid);

            index_base = find(baseline == 1);
            
            nch = ndata./2;
            nirsdata.oxyData = [];
            nirsdata.dxyData = [];
            nirsdata.totalData = [];
            
            for kk = 1:nch
                waitbar(kk/(nch-1), h_wait);
                [hb_tmp, hbo_tmp, hbt_tmp] = mes2hb(mes(:,2*kk-1:2*kk), [wav_mat(1,2*kk-1) wav_mat(1,2*kk)], [index_base(1) index_base(end)]);
                nirsdata.oxyData(:,kk) = hbo_tmp;
                nirsdata.dxyData(:,kk) = hb_tmp;
                nirsdata.totalData(:,kk) = hbt_tmp;
            end
            
            try
                vector_onset(index_base(1):index_base(end)) = [];
                nirsdata.vector_onset = vector_onset(:);
            end
            nirsdata.T = 1./fs;
            nirsdata.nch = nch;
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            
            nirsdata.subject=files(sub).name(1:end-4);
            nirsdata.system='HITACHI4000 OD 1set';
            
            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end
            
            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            
            save(fullfile(outpath,[files(sub).name(1:end-4),'mat']),'nirsdata');
            
            waitbar(sub/n, h_wait, 'Data convertion processing ... ...');

        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
        
        
    % Type 2: HITACHI4000 (OD, 2set, *.csv) -------------------------------  
    case 2
        files = dir(fullfile(inpathData,'*.csv'));
        h_wait = waitbar(0, 'Please wait... ');
        n = size(files,1)./2;
        
        for sub=1:2:size(files,1)
            subfile1=fullfile(inpathData,files(sub).name);
            subfile2=fullfile(inpathData,files(sub+1).name);
            
            % reading the dataset from the 1nd probe 
            fid = fopen(subfile1);
                 
            % start reading data
            while 1
                tline = fgetl(fid);

            % HX 20231010 data split type ---------------------------------       
                if find(tline == ',', 1) 
                    uni_str = ',';
                elseif find(tline == ' ', 1)
                    uni_str = '	';
                end
            % HX 20231010 data split type ---------------------------------

                if contains(tline, 'Wave Length')  %reading wave lengths on each probe
                    nindex = find(tline == uni_str);
                    tline(nindex) = ' ';
                    txt_wavelength = tline(nindex(1)+1:end);
                    error_index = strfind(txt_wavelength, '..');
                    txt_wavelength(error_index) =  [];

                    remain = txt_wavelength;
                    ndata = 0;
                    wav_mat = [];
                    while 1
                        [token remain] = strtok(remain);
                        if isempty(token) == 1
                            break;
                        end
                        sind = find(token == '(')+1;
                        eind = find(token == ')')-1;
                        wav_mat = [wav_mat str2num(token(sind:eind))];
                        ndata = ndata + 1;
                    end
                elseif contains(tline, 'Sampling Period[s]') % reading sampling period
                    nindex = find(tline ==  uni_str);
                    tline(nindex) = ' ';
                    txt_fs = tline(nindex(1)+1:end);
                    try
                        fs = 1./mean(str2num(txt_fs));
                    catch
                        error_index = strfind(txt_fs, '..');
                        txt_fs(error_index) = [];
                        fs = 1./mean(str2num(txt_fs));
                    end
                elseif contains(tline, 'Probe1') 
                    disp('Reading the data from Probe1 ...');
                    nindex = find(tline ==  uni_str);
                    txt_probe = tline(nindex(1)+1:end);
                    index_tmp = find(txt_probe == uni_str);
                    txt_probe(index_tmp) = ' ';
                    [token remain] = strtok(txt_probe);
                    count = 3;
                    while isempty(token) ~= 1
                        [token remain] = strtok(remain);
                        if strcmp(token, 'Mark') == 1
                            col_mark = count;
                        end
                        if strcmp(token, 'PreScan') == 1
                            col_prescan = count;
                        end
                        count = count + 1;
                    end
                    while 1
                        tline = fgetl(fid);
                        if ischar(tline) == 0, break, end
                        nindex = find(tline == uni_str);
                        try
                            count = str2num(tline(1:nindex(1)-1));
                            tline(nindex) = ' ';
                            try
                                mes(count, :) = str2num(tline(nindex(1)+1:nindex(ndata+1)-1));
                            catch
                                str = tline(nindex(1)+1:nindex(ndata+1)-1);
                                error_index = strfind(str, '..');
                                str(error_index) = [];
                                mes(count, :) = str2num(str);
                            end
                            try
                                baseline(count) = str2num(tline(nindex(col_prescan-1)+1:nindex(col_prescan)-1));
                            catch
                                baseline(count) = str2num(tline(nindex(col_prescan-1)+1:end));
                            end
                            try
                                vector_onset1(count) = str2num(tline(nindex(col_mark-1)+1:nindex(col_mark)-1));
                            end
                        end
                    end
                    disp('Completed.');
                    break,
                end
            end
            
            fclose(fid);
            
            index_base = find(baseline == 1);
            nch = ndata./2;
            dxyData1=[];oxyData1=[];totalData1=[];
            for kk = 1:nch
                [dxyData1(:,kk), oxyData1(:,kk), totalData1(:,kk)] = mes2hb(mes(:,2*kk-1:2*kk), [wav_mat(1,2*kk-1) wav_mat(1,2*kk)], [index_base(1) index_base(end)]);
            end
            
            try
                vector_onset1(index_base(1):index_base(end)) = [];
            end
            clear mes;
            clear baseline;

            % reading the dataset from the 2nd probe 
            fid = fopen(subfile2);

            while 1
                tline = fgetl(fid);

            % HX 20231010 data split type ---------------------------------       
                if find(tline == ',', 1) 
                    uni_str = ',';
                elseif find(tline == ' ', 1)
                    uni_str = '	';
                end
            % HX 20231010 data split type ---------------------------------

                if contains(tline, 'Wave Length') %reading wave lengths on each probe
                    nindex = find(tline == uni_str);
                    tline(nindex) = ' ';
                    txt_wavelength = tline(nindex(1)+1:end);
                    error_index = strfind(txt_wavelength, '..');
                    txt_wavelength(error_index) =  [];

                    remain = txt_wavelength;
                    ndata = 0;
                    wav_mat = [];
                    while 1
                        [token remain] = strtok(remain);
                        if isempty(token) == 1
                            break;
                        end
                        sind = find(token == '(')+1;
                        eind = find(token == ')')-1;
                        wav_mat = [wav_mat str2num(token(sind:eind))];
                        ndata = ndata + 1;
                    end
                elseif contains(tline, 'Probe2')
                    disp('Reading the data from Probe2 ...');
                    nindex = find(tline ==  uni_str);
                    txt_probe = tline(nindex(1)+1:end);
                    index_tmp = find(txt_probe == uni_str);
                    txt_probe(index_tmp) = ' ';
                    [token remain] = strtok(txt_probe);
                    count = 3;
                    while isempty(token) ~= 1
                        [token remain] = strtok(remain);
                        if strcmp(token, 'Mark') == 1
                            col_mark = count;
                        end
                        if strcmp(token, 'PreScan') == 1
                            col_prescan = count;
                        end
                        count = count + 1;
                    end
                    while 1
                        tline = fgetl(fid);
                        if ischar(tline) == 0, break, end,
                        nindex = find(tline == uni_str);
                        try
                            count = str2num(tline(1:nindex(1)-1));
                            tline(nindex) = ' ';
                            try
                                mes(count, :) = str2num(tline(nindex(1)+1:nindex(ndata+1)-1));
                            catch
                                str = tline(nindex(1)+1:nindex(ndata+1)-1);
                                error_index = strfind(str, '..');
                                str(error_index) = [];
                                mes(count, :) = str2num(str);
                            end
                            try
                                baseline(count) = str2num(tline(nindex(col_prescan-1)+1:nindex(col_prescan)-1));
                            catch
                                baseline(count) = str2num(tline(nindex(col_prescan-1)+1:end));
                            end
                            try
                                vector_onset2(count) = str2num(tline(nindex(col_mark-1)+1:nindex(col_mark)-1));
                            end
                        end
                    end
                    disp('Completed.');
                    break,
                end
            end
            fclose(fid);

            index_base = find(baseline == 1);
            dxyData2=[];oxyData2=[];totalData2=[];
            for kk = 1:nch
                [dxyData2(:,kk), oxyData2(:,kk), totalData2(:,kk)] = mes2hb(mes(:,2*kk-1:2*kk), [wav_mat(1,2*kk-1) wav_mat(1,2*kk)], [index_base(1) index_base(end)]);
            end
            
            clear mes;
            clear baseline;

            try
                vector_onset2(index_base(1):index_base(end)) = [];
                index_onset = find(vector_onset1 ~= vector_onset2);
                if isempty(index_onset) == 1
                    nirsdata.vector_onset = vector_onset1(:);
                end
            end

            nch = size(oxyData1, 2) + size(oxyData2, 2);
            nirsdata.oxyData = zeros(size(oxyData1,1), nch);
            nirsdata.dxyData = zeros(size(dxyData1,1), nch);
            nirsdata.totalData =zeros(size(totalData1,1),nch);

            nirsdata.oxyData(:, 1:size(oxyData1,2)) = oxyData1(:,:);
            nirsdata.oxyData(:, size(oxyData1,2)+1:end) = oxyData2(:,:);
            nirsdata.dxyData(:, 1:size(dxyData1,2)) = dxyData1(:,:);
            nirsdata.dxyData(:, size(dxyData1,2)+1:end) = dxyData2(:,:);
            nirsdata.totalData(:, 1:size(totalData1,2)) = totalData1(:,:);
            nirsdata.totalData(:,size(dxyData1,2)+1:end) = totalData2(:,:);
            
            nirsdata.T = 1./fs;
            nirsdata.nch = nch;
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            
            sname= regexp(files(sub).name,'_','split');
            subname=files(sub).name(1:end-length(sname{end})-1);
            nirsdata.subject=subname;
            nirsdata.system='HITACHI4000 HB 1set';
            
            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end
            
            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            
            save(fullfile(outpath,[subname,'.mat']),'nirsdata');
            
            waitbar(sub/n, h_wait, 'Data convertion processing ... ...');
            
        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
                    
    
    % Type 3: NIRX (OD, *.wl1 & *.wl2)  -----------------------------------
    case 3        
        files = dir(fullfile(inpathData,'*.wl1'));
        h_wait = waitbar(0, 'Please wait... ');
        n = size(files,1);

        % parameters indentification
        disp('Reading the parameters for modified Beer-Lambert law starts...');
        parameters=get(handles.datatype,'userdata');
        nch = str2num(parameters{1});
        fs = str2num(parameters{2});
        dist = str2num(parameters{3});
        wavelength = str2num(parameters{4});
        DPF = str2num(parameters{5});
        ecoef = str2num(parameters{6});
        config_file=parameters{7};
        config=importdata(config_file);
        config=config(1:nch,:);
        disp('Completed.');
        
        if isempty(ecoef) == 1
            load COPE_e_coef; % load the extinction coefficient file
            ecoef1 = e_coef(find(e_coef(:,1) == wavelength(1,1)),2:3);
            ecoef2 = e_coef(find(e_coef(:,1) == wavelength(1,2)),2:3);
            ecoef = [ecoef1,ecoef2];
        end
                
        % =================================================================
        for sub=1:size(files,1)
            
            % read wl1 ----------------------------------------------------
            mes1=importdata(fullfile(inpathData,files(sub).name));
            disp([files(sub).name,' Completed.']);
            
            % read wl2 ----------------------------------------------------
            mes2=importdata(fullfile(inpathData,[files(sub).name(1:end-3),'wl2']));
            disp([files(sub).name(1:end-3),'wl2',' Completed.']);
            
            % Converting optical density changes to hemoglobin changes
            disp(['Converting optical density changes to hemoglobin changes for ',files(sub).name(1:end-4),' ... ...']);
            nTx = max(config(:,1)); 
            nRx = max(config(:,2));
            if size(mes1, 2) ~= nTx*nRx || size(mes2, 2) ~= nTx*nRx
                nTx = inputdlg('Please enter the number of sources');
                nTx = str2num(cell2mat(nTx));
                nRx = inputdlg('Please enter the number of detectors');
                nRx = str2num(cell2mat(nRx));
            end
            
            s1=size(mes1,1);
            mes1_log = real(-log10((mes1)./(repmat(mean(mes1,1),[s1,1]))));
            mes2_log = real(-log10((mes2)./(repmat(mean(mes2,1),[s1,1]))));        
            
            coefMat = dist.*(diag(DPF)*[ecoef(1,1:2);ecoef(1,3:4)]);
            coefMat = pinv(coefMat);

            for kk = 1:nch
                index = (config(kk, 1)-1)* nRx + config(kk,2);
                oxydxy = coefMat * [mes1_log(:,index)'; mes2_log(:,index)'];
                oxyData(:, kk) = oxydxy(1,:)';
                dxyData(:, kk) = oxydxy(2,:)';
            end
            disp('Completed.');

            % output and save for NIRS_KIT
            nirsdata.oxyData = oxyData;
            nirsdata.dxyData = dxyData;
            nirsdata.totalData = oxyData+dxyData;
            
            nirsdata.T = 1/fs;
            nirsdata.nch = nch;
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            nirsdata.vector_onset = zeros(size(nirsdata.dxyData,1),1);
            nirsdata.subject = files(sub).name(1:end-4);
            nirsdata.system = 'NIRX';
            nirsdata.param = parameters;
            
            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end
            
            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            
            save(fullfile(outpath,[files(sub).name(1:end-4),'mat']),'nirsdata');
            
            waitbar(sub/n, h_wait, 'Data convertion processing ... ...');
            
        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);    
    
    % Type 4; HITACHI4000 (HB, 1set, *.csv) --------------------------------------
    case 4
        k = 0;   % waitbar length
        h_wait = waitbar(k, 'Please wait... ');
        files = dir(fullfile(inpathData,'*.csv'));

        n = length(files);
        fmarks=zeros(1,n);
        for i=1:n
            if(fmarks(i)) continue; end
            if(~strcmp(files(i).name(end-6:end),'Oxy.csv')) continue;end
            nirsdata_oxy = NR_etg_hb2xy(fullfile(inpathData,files(i).name));   % HBA_Probe1_Oxy.csv
            nirsdata_dxy = NR_etg_hb2xy(fullfile(inpathData,[files(i).name(1:end-7),'Deoxy.csv']));
            nirsdata_txy = NR_etg_hb2xy(fullfile(inpathData,[files(i).name(1:end-7),'Total.csv']));
            % generate standard data
            nirsdata.oxyData = nirsdata_oxy.Data;
            nirsdata.dxyData = nirsdata_dxy.Data;
            nirsdata.totalData = nirsdata_txy.Data;
            nirsdata.nch = nirsdata_oxy.nch;
            nirsdata.T = nirsdata_oxy.T;
            nirsdata.vector_onset = nirsdata_oxy.vector_onset;
            subject = files(i).name(1:end-19);
            nirsdata.subject = subject;
            nirsdata.system = 'HITACHI4000/7000 HB';
            nirsdata.exception_channel = nirsdata_oxy.exception_channel;
            nirsdata.probeSet = nirsdata_oxy.probeSet;
            %
            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id)== nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end
            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            save(fullfile(outpath,[subject,'.mat']),'nirsdata');
            waitbar(i/n, h_wait, 'Data convertion processing ... ...');
        end
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
        
    % Type 5: HITACHI4000 (HB, 2set, *.csv) --------------------------------------
    case 5
        k = 0;   % waitbar length
        h_wait = waitbar(k, 'Please wait... ');
        files = dir(fullfile(inpathData,'*.csv'));
        n = length(files);
        
        fmarks=zeros(1,n);
        for i=1:n
            if(fmarks(i)) continue; end
            if(~strcmp(files(i).name(end-13:end),'Probe1_Oxy.csv')) continue;end
            nirsdata1_oxy = NR_etg_hb2xy(fullfile(inpathData,files(i).name));   % HBA_Probe1_Oxy.csv
            waitbar(i/n, h_wait, 'Data convertion processing ... ...');
            nirsdata1_dxy = NR_etg_hb2xy(fullfile(inpathData,[files(i).name(1:end-14),'Probe1_Deoxy.csv']));
            waitbar((i+1)/n, h_wait, 'Data convertion processing ... ...');
            nirsdata1_txy = NR_etg_hb2xy(fullfile(inpathData,[files(i).name(1:end-14),'Probe1_Total.csv']));
            waitbar((i+2)/n, h_wait, 'Data convertion processing ... ...');
            nirsdata2_oxy = NR_etg_hb2xy(fullfile(inpathData,[files(i).name(1:end-14),'Probe2_Oxy.csv']));
            waitbar((i+3)/n, h_wait, 'Data convertion processing ... ...');
            nirsdata2_dxy = NR_etg_hb2xy(fullfile(inpathData,[files(i).name(1:end-14),'Probe2_Deoxy.csv']));
            waitbar((i+4)/n, h_wait, 'Data convertion processing ... ...');
            nirsdata2_txy = NR_etg_hb2xy(fullfile(inpathData,[files(i).name(1:end-14),'Probe2_Total.csv']));
            waitbar((i+5)/n, h_wait, 'Data convertion processing ... ...');
            % combine
            nirsdata1 = nirsdata1_oxy;  nirsdata2 = nirsdata2_oxy;
            nirsdata1.Data = [];  nirsdata2.Data = [];
            nirsdata1.oxyData = nirsdata1_oxy.Data;     nirsdata2.oxyData = nirsdata2_oxy.Data;
            nirsdata1.dxyData = nirsdata1_dxy.Data;     nirsdata2.dxyData = nirsdata2_dxy.Data;
            nirsdata1.totalData = nirsdata1_txy.Data;   nirsdata2.totalData = nirsdata2_txy.Data;
            nch = nirsdata1.nch+nirsdata2.nch;
            nirsdata.oxyData = zeros(size(nirsdata1.oxyData,1), nch);
            nirsdata.dxyData = zeros(size(nirsdata1.dxyData,1), nch);
            nirsdata.oxyData(:, 1:size(nirsdata1.oxyData,2)) = nirsdata1.oxyData(:,:);
            nirsdata.oxyData(:, size(nirsdata1.oxyData,2)+1:end) = nirsdata2.oxyData(:,:);
            nirsdata.dxyData(:, 1:size(nirsdata1.dxyData,2)) = nirsdata1.dxyData(:,:);
            nirsdata.dxyData(:, size(nirsdata1.dxyData,2)+1:end) = nirsdata2.dxyData(:,:);
            nirsdata.totalData = nirsdata.oxyData + nirsdata.dxyData;
            % generate standard data
            nirsdata.T = nirsdata1.T;
            nirsdata.nch = nch;
            nirsdata.probeSet = nirsdata1.probeSet;
            nirsdata.exception_channel = [nirsdata1.exception_channel,nirsdata1.exception_channel];
            nirsdata.vector_onset = nirsdata1.vector_onset;
            subject = files(i).name(1:end-19);
            nirsdata.subject = subject;
            nirsdata.system = 'HITACHI4000/7000 HB';
            fmarks(i)=1;
            nirsdata.probeSet = {nirsdata1.probeSet,nirsdata2.probeSet};
            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end
            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            save(fullfile(outpath,[files(i).name(1:end-19),'.mat']),'nirsdata');
        end
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
        
    % Type 6: SHIMADU LABNIRS (HB, *.txt) ---------------------------------
    case 6
        files = dir(fullfile(inpathData,'*.TXT'));
        if isempty(files)
            files = dir(fullfile(inpathData,'*.txt'));
        end
        for i = 1:length(files)
            filename = files(i).name;
            nirsdata = NR_nlab_hb2xy(fullfile(inpathData,char(filename)));
            nirsdata.probeSet = {};
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            subject = filename(1:end-4);
            nirsdata.subject = subject;
            nirsdata.system = 'SHIMADU LABNIRS HB'; 
            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end
            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            save(fullfile(outpath,[filename(1:end-4),'.mat']),'nirsdata');
        end
     
        
    % Type 7: manual input OD data    
    case 7
        files = dir(fullfile(inpathData,'*.csv'));
        h_wait = waitbar(0, 'Please wait... ');
        n = size(files,1);

        % parameters indentification
        disp('Reading the parameters for modified Beer-Lambert law starts...');
        parameters=get(handles.datatype,'userdata');
        nch = str2num(parameters{1});
        fs = str2num(parameters{2});
        dist = str2num(parameters{3});
        wavelength = str2num(parameters{4});
        rwavelength = round(wavelength);
        rwavelength = reshape(rwavelength, [2 size(rwavelength,2)/2])';
        DPF = str2num(parameters{5});
        ecoef = str2num(parameters{6})';
               
        flag_param = 0;
        if length(dist) == 1
           dist = dist * ones(nch,1);
           flag_param = flag_param + 1;
        end
        
        if length(rwavelength) == 2
            rwavelength = ones(nch,1) * rwavelength;
            flag_param = flag_param + 1;
        end
        
%         if length(DPF) == 1
%             DPF = DPF * ones(nch,1);
%             flag_param = flag_param + 1;
%         end
        
        if ~isempty(DPF) == 1
            DPF = repmat(DPF,[nch,1]);
            flag_param = flag_param + 1;
        end
        
        if length(ecoef) == 4 || isempty(ecoef) == 1
             try
                ecoef = ecoef * ones(1, nch);
                ecoef = ecoef(:);
                flag_param = flag_param + 1;
            end
        end
        
        if flag_param == 4 % same parameters will be applied to all channels
            if isempty(ecoef) == 1
                load COPE_e_coef; % load the extinction coefficient file
                index_wav1 = find(e_coef(:,1) == rwavelength(1,1));
                index_wav2 = find(e_coef(:,1) == rwavelength(1,2));
                wav1_ecoef = e_coef(index_wav1,2:3);
                wav2_ecoef = e_coef(index_wav2,2:3);
            else
                wav1_ecoef = ecoef(1:2,1)';
                wav2_ecoef = ecoef(3:4,1)';
            end

            tot_ecoef = [wav1_ecoef; wav2_ecoef];
            tot_ecoef = tot_ecoef .* DPF(1,1) .* dist(1,1);
            coefMat = pinv(tot_ecoef);
            coefMat = reshape(coefMat(:) * ones(1, nch), [2 2 nch]);
        else %% channel-wise parameters (DPF, extinction coefficient, distance)
            coefMat = zeros(2, 2, nch);
            for kk = 1:nch
                if isempty(ecoef) == 1
                    load COPE_e_coef; % load the extinction coefficient file
                    index_wav1 = find(e_coef(:,1) == rwavelength(kk,1));
                    index_wav2 = find(e_coef(:,1) == rwavelength(kk,2));
                    wav1_ecoef = e_coef(index_wav1,2:3);
                    wav2_ecoef = e_coef(index_wav2,2:3);
                else
                    wav1_ecoef = ecoef(4*kk-3:4*kk-2,1)';
                    wav2_ecoef = ecoef(4*kk-1:4*kk,1)';
                end
                
                tot_ecoef = [wav1_ecoef; wav2_ecoef];
                tot_ecoef = tot_ecoef .* DPF(kk,1) .* dist(kk,1);
                coefMat(:,:, kk) = pinv(tot_ecoef);
            end
        end % reading the coefficient matrix
        
        % Beer-Lambert law ------------------------------------------------
        for sub=1:size(files,1)
            subfile=fullfile(inpathData,files(sub).name);
            mes = xlsread(subfile);
            for kk = 1:nch
                oxydxy = (coefMat(:,:,kk) * [mes(:,2*(kk-1)+1)'; mes(:, 2*kk)'])';
                oxyData(:,kk) = oxydxy(:,1);
                dxyData(:,kk) = oxydxy(:,2);
            end
            
            if exist('nirsdata', 'var')
                clear nirsdata;
            end

            nirsdata.oxyData=oxyData;
            nirsdata.dxyData=dxyData;
            nirsdata.totalData=nirsdata.oxyData+nirsdata.dxyData;

            nirsdata.nch=nch;
            nirsdata.T=1./fs;
            nirsdata.vector_onset=zeros(size(nirsdata.oxyData,1),1);
            nirsdata.exception_channel = zeros(1,nirsdata.nch);

            subname=files(sub).name(1:end-4);
            nirsdata.subject = subname;
            nirsdata.system = 'Manual input optical density';
            nirsdata.parameters=parameters;

            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end

            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end

            save(fullfile(outpath,[subname,'.mat']),'nirsdata');

            waitbar(sub/n, h_wait, 'Data convertion processing ... ...');  
        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
    
        
    % Type 8: manual input HB data    
    case 8 
        files = dir(fullfile(inpathData,'*.csv'));
        h_wait = waitbar(0, 'Please wait... ');
        n = size(files,1);

        % parameters indentification
        parameters=get(handles.datatype,'userdata');
        nch=str2num(parameters{1});
        fs = str2num(parameters{2});
        
        for sub=1:n
            subfile=fullfile(inpathData,files(sub).name);
            HB_Data=xlsread(subfile);
            [ntp,nn]=size(HB_Data);
            
            if exist('nirsdata','var')
               clear nirsdata;
            end
            
            if nn == 2*nch
                for ch=1:nch
                    nirsdata.oxyData(:,ch)=HB_Data(:,(ch-1)*2+1);
                    nirsdata.dxyData(:,ch)=HB_Data(:,(ch-1)*2+2);
                end
                    nirsdata.totalData=nirsdata.oxyData+nirsdata.dxyData;
                
            else nn == 3*nch
                for ch=1:nch
                    nirsdata.oxyData(:,ch)=HB_Data(:,(ch-1)*3+1);
                    nirsdata.dxyData(:,ch)=HB_Data(:,(ch-1)*3+2);
                    nirsdata.totalData(:,ch)=HB_Data(:,(ch-1)*3+3);
                end
            end
            
            nirsdata.T=1./fs;
            nirsdata.nch=nch;
            nirsdata.vector_onset=zeros(ntp,1);
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            
            nirsdata.subject=files(sub).name(1:end-4);
            nirsdata.system='Manual input HB';
            
            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end

            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end

            save(fullfile(outpath,[files(sub).name(1:end-4),'.mat']),'nirsdata');

            waitbar(sub/n, h_wait, 'Data convertion processing ... ...');  
        end
  
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait); 
         
        
    % Type 9: NIRS_SPM HB (raw, *.mat) ------------------------------------
    case 9
        files = dir(fullfile(inpathData,'*.mat'));
        h_wait = waitbar(0, 'Please wait... ');
        n = length(files)
        for i = 1:length(files)
            filename = files(i).name;
            load(fullfile(inpathData,files(i).name));
            nirsdata.oxyData = nirs_data.oxyData;
            nirsdata.dxyData = nirs_data.dxyData;
            
            if isfield(nirs_data,'tHbData')
                nirsdata.totalData = nirs_data.tHbData;
            else
                nirsdata.totalData = nirs_data.oxyData + nirs_data.dxyData;
            end
            
            if isfield(nirs_data,'vector_onset')
                nirsdata.vector_onset = nirs_data.vector_onset;
            else
                nirsdata.vector_onset = zeros(size(nirs_data.dxyData,1),1);
            end
            nirsdata.T = 1/nirs_data.fs;
            nirsdata.nch = nirs_data.nch;
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            nirsdata.subject = filename(1:end-4);
            nirsdata.system = 'NIRS_SPM_HB_Raw';

            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end
            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            
            save(fullfile(outpath,filename),'nirsdata');
            waitbar(i/n, h_wait, 'Data convertion processing ... ...');
        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
        
        
    % Type 10: NIRS_SPM HB (preprocessed, *.mat) ------------------------------------
    case 10
        files = dir(fullfile(inpathData,'*.mat'));
        h_wait = waitbar(0, 'Please wait... ');
        n = length(files)
        for i = 1:length(files)
            filename = files(i).name;
            load(fullfile(inpathData,files(i).name));
            nirsdata.oxyData = nirs_data.oxyData;
            nirsdata.dxyData = nirs_data.dxyData;
            
            if isfield(nirs_data,'tHbData')
                nirsdata.totalData = nirs_data.tHbData;
            else
                nirsdata.totalData = nirs_data.oxyData + nirs_data.dxyData;
            end
            
            if isfield(nirs_data,'vector_onset')
                nirsdata.vector_onset = nirs_data.vector_onset;
            else
                nirsdata.vector_onset = zeros(size(nirs_data.dxyData,1),1);
            end
            nirsdata.T = 1/nirs_data.fs;
            nirsdata.nch = nirs_data.nch;
            nirsdata.vector_onset=zeros(size(nirsdata.oxyData,1),1);
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            nirsdata.subject = filename(1:end-4);
            nirsdata.system = 'NIRS_SPM_HB_Preprocessed';

            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end
            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            
            save(fullfile(outpath,filename),'nirsdata');
            waitbar(i/n, h_wait, 'Data convertion processing ... ...');
        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
        
        
    % Type 11: HomER2 OD (raw, *.nirs) ------------------------------------
    case 11  
        files = dir(fullfile(inpathData,'*.nirs'));
        
        h_wait = waitbar(0, 'Please wait... ');
        n = size(files,1);
        
        % parameters indentification
        parameters=get(handles.datatype,'userdata');
        ppf=str2num(parameters{1});
        
        for sub=1:size(files,1)
            load(fullfile(inpathData,files(sub).name),'-mat');
            
            dod = hmrIntensity2OD(d);
            dc = hmrOD2Conc(dod,SD,ppf );
            
            nch = size(dc,3);
            nTpts = size(dc,1);

            nirsdata.oxyData = dc(:,1,:);
            nirsdata.oxyData = reshape(nirsdata.oxyData,nTpts,nch);
            nirsdata.dxyData = dc(:,2,:);
            nirsdata.dxyData = reshape(nirsdata.dxyData,nTpts,nch);
            nirsdata.totalData = dc(:,3,:);
            nirsdata.totalData = reshape(nirsdata.totalData,nTpts,nch);

            try
                nirsdata.vector_onset = s;
            catch
                nirsdata.vector_onset = zeros(nTpts,1);
            end
            nirsdata.T = t(end)./length(t);
            nirsdata.nch = nch;
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            
            [~,subname,~]=fileparts(fullfile(inpathData,files(sub).name));
            nirsdata.subject = subname;
            nirsdata.system = 'Homer2 Raw';

            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end

            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            
            save(fullfile(outpath,[subname,'.mat']),'nirsdata');
            
            waitbar(sub/n, h_wait, 'Data convertion processing ... ...');  
            
        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
        
     % Type 12: HomER2 OD (preprocessed, *.nirs) ------------------------------------
     case 12
        files = dir(fullfile(inpathData,'*.nirs'));
        
        h_wait = waitbar(0, 'Please wait... ');
        n = size(files,1);
                
        for sub=1:size(files,1)
            load(fullfile(inpathData,files(sub).name),'-mat');
                        
            nch = size(procResult.dc,3);
            nTpts = size(procResult.dc,1);

            nirsdata.oxyData = procResult.dc(:,1,:);
            nirsdata.oxyData = reshape(nirsdata.oxyData,nTpts,nch);
            nirsdata.dxyData = procResult.dc(:,2,:);
            nirsdata.dxyData = reshape(nirsdata.dxyData,nTpts,nch);
            nirsdata.totalData = procResult.dc(:,3,:);
            nirsdata.totalData = reshape(nirsdata.totalData,nTpts,nch);
                        
            try
                nirsdata.vector_onset = procResult.s;
            catch
                nirsdata.vector_onset = zeros(nTpts,1);
            end
            nirsdata.nch = nch;
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            nirsdata.T = t(end)./length(t);
            
            [~,subname,~]=fileparts(fullfile(inpathData,files(sub).name));
            nirsdata.subject = subname;
            nirsdata.system = 'Homer2 processed';

            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end

            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            
            save(fullfile(outpath,[subname,'.mat']),'nirsdata');
            
            waitbar(sub/n, h_wait, 'Data convertion processing ... ...');  
            
        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);
        
    % Type 13: HomER3 OD (raw, *.snirf) -----------------------------------     
    case 13
        files = dir(fullfile(inpathData,'*.snirf'));
        
        h_wait = waitbar(0, 'Please wait... ');
        n = size(files,1);
        
        % parameters indentification
        parameters=get(handles.datatype,'userdata');
        ppf=str2num(parameters{1});

        design_inf = {};

        for sub=1:size(files,1)
            intensity=SnirfClass(fullfile(inpathData,files(sub).name));
            probe=intensity(1).probe;
            nTpts = length(intensity.data.time);
            if size(intensity.data.dataTimeSeries,2) == nTpts
                intensity.data.dataTimeSeries=intensity.data.dataTimeSeries';
            end
               
            dod = hmrR_Intensity2OD_nk( intensity );
            nWav=length(intensity.probe.wavelengths);
            
            if nWav == 2
                dcr = hmrR_OD2Conc(dod,probe,ppf);
            elseif nWav == 3
                dcr = hmrR_OD2Conc_3(dod,probe,ppf);
            else nWav > 3
                dcr = hmrR_OD2Conc_multi(dod,probe,ppf);
            end
            
            dc = dcr.GetDataTimeSeries();

            nch = size(dc,2)/3;
            nirsdata.oxyData = [];
            nirsdata.dxyData = [];
            nirsdata.totalData = [];
            
            for ch=1:nch
                nirsdata.oxyData(:,ch) = dc(:,(ch-1)*3+1);
                nirsdata.dxyData(:,ch) = dc(:,(ch-1)*3+2);
                nirsdata.totalData(:,ch) = dc(:,(ch-1)*3+3);
            end

            nirsdata.vector_onset = zeros(nTpts,1);
            nirsdata.T = dcr.time(end)/length(dcr.time);
            nirsdata.nch = nch;
            nirsdata.exception_channel = zeros(1,nirsdata.nch);
            
            [~,subname,~]=fileparts(fullfile(inpathData,files(sub).name));
            nirsdata.subject = subname;
            nirsdata.system = 'Snirf Raw';

            if isProbe2d
                for probeSetid = 1:length(probeSets)
                    max_id(probeSetid)=max(probeSets{probeSetid}.probeSet(:))-1000;
                end
                if max(max_id) == nirsdata.nch
                    nirsdata.probe2d = probeSets;
                else
                    nirsdata.probe2d = {};
                    msgbox({'The probeset inputted has a wrong number of channels!!!';'It will not been added to the converted file!!!'},'Warning','warn');
                end
            else
                nirsdata.probe2d = {};
            end

            if isProbe3d
                fln_3d=dir(fullfile(inpath3d,'*.mat'));
                if size(fln_3d,1) ==1
                    load(fullfile(inpath3d,fln_3d(1).name));
                    nirsdata.probe3d = ch_data;
                else
                    load(fullfile(inpath3d,[subject,'.mat']));
                    nirsdata.probe3d = ch_data;
                end
            else
                nirsdata.probe3d = {};
            end
            
            save(fullfile(outpath,[subname,'.mat']),'nirsdata');
            
            waitbar(sub/n, h_wait, 'Data convertion processing ... ...');  

            % HX 20231021 snirf design_inf_maker -----------------------
            try
                design_inf = snirf_design_inf_maker(subname,intensity.stim,design_inf);
            end
            % HX 20231021 snirf design_inf_maker -----------------------
            
        end
        
        waitbar(1, h_wait, 'Data convertion finished !');
        close(h_wait);

        if ~isempty(design_inf) && size(design_inf,1)-1 == n
            [file,path] = uiputfile('design_inf.mat','Save Design_Inf.mat in seconds');
           save(fullfile(path,file),'design_inf');
        end
end

msgbox('Data Integration Completed !','Success','help');
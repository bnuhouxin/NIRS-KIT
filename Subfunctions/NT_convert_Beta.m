function dataSource = NT_convert_Beta(FileName,PathName,dataType)

% NT_convert_Beta convert data from equipment to stadard data, and add
% 2d\3d data


% type 1: HITACHI ETG4000 (1 set)
% type 2: HITACHI ETG4000 (2 set) 
% type 3: SHIMADU LABNIRS; 

filename={};
switch dataType
    %% HITACHI ETG4000 HB (1 set)
    case 1
        h_wait = waitbar(0, 'Please wait... ');
        for i=1:3
            if(strcmp(FileName{i}(end-7:end),'_Oxy.csv'))
                nirsdata_oxy = NR_etg_hb2xy([PathName FileName{i}]);   % liuweijie_HBA_Probe1_Oxy.csv
                subject = FileName{i}(1:end-19);
            end
            if(strcmp(FileName{i}(end-9:end),'_Deoxy.csv'))
                nirsdata_dxy = NR_etg_hb2xy([PathName FileName{i}]);
            end
            if(strcmp(FileName{i}(end-9:end),'_Total.csv'))
                nirsdata_txy = NR_etg_hb2xy([PathName FileName{i}]);
            end
            waitbar(i/3, h_wait, 'Loading data ... ...');
        end
        % make standard data
        nirsdata.oxyData = nirsdata_oxy.Data;
        nirsdata.dxyData = nirsdata_dxy.Data; 
        nirsdata.totalData = nirsdata_txy.Data; 
        nirsdata.nch = nirsdata_oxy.nch;
        nirsdata.T = nirsdata_oxy.T;
        nirsdata.vector_onset = nirsdata_oxy.vector_onset;
        nirsdata.subject = subject;
        nirsdata.system = 'HITACHI ETG4000';
        nirsdata.exception_channel = nirsdata_oxy.exception_channel;
        nirsdata.probeSet = nirsdata_oxy.probeSet;
        nirsdata.probe2d = {};
        dataSource = [PathName subject '.mat'];
        save(dataSource,'nirsdata');
        waitbar(1, h_wait, 'Done!');
        close(h_wait);
        
    %% HITACHI ETG4000 (2 set)
    case 2 
        h_wait = waitbar(0, 'Please wait... ');
        for i=1:6
            if(strcmp(FileName{i}(end-13:end),'Probe1_Oxy.csv'))
                nirsdata1_oxy = NR_etg_hb2xy([PathName FileName{i}]);   % liuweijie_HBA_Probe1_Oxy.csv
                subject = FileName{i}(1:end-19);
            end
            if(strcmp(FileName{i}(end-13:end),'Probe2_Oxy.csv'))
                nirsdata2_oxy = NR_etg_hb2xy([PathName FileName{i}]);   % liuweijie_HBA_Probe1_Oxy.csv
                subject = FileName{i}(1:end-19);
            end
            if(strcmp(FileName{i}(end-15:end),'Probe1_Deoxy.csv'))
                nirsdata1_dxy = NR_etg_hb2xy([PathName FileName{i}]);
            end
            if(strcmp(FileName{i}(end-15:end),'Probe2_Deoxy.csv'))
                nirsdata2_dxy = NR_etg_hb2xy([PathName FileName{i}]);
            end
            if(strcmp(FileName{i}(end-15:end),'Probe1_Total.csv'))
                nirsdata1_txy = NR_etg_hb2xy([PathName FileName{i}]);
            end
            if(strcmp(FileName{i}(end-15:end),'Probe2_Total.csv'))
                nirsdata2_txy = NR_etg_hb2xy([PathName FileName{i}]);
            end
            waitbar(i/6, h_wait, 'Loading data ... ...');
        end
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
        % generate standard format data
        nirsdata.T = nirsdata1.T;
        nirsdata.nch = nch;
        nirsdata.probeSet = nirsdata1.probeSet;
        nirsdata.exception_channel = nirsdata1.exception_channel;
        nirsdata.vector_onset = nirsdata1.vector_onset;
        nirsdata.subject = subject;
        nirsdata.system = 'HITACHI ETG4000';
        fmarks(i)=1;
        nirsdata.probeSet = {nirsdata1.probeSet,nirsdata2.probeSet};
        nirsdata.probe2d = {};
        dataSource = [PathName subject '.mat'];
        save(dataSource,'nirsdata');
        waitbar(1, h_wait, 'Done!');
        close(h_wait);
%     
    %% SHIMADU LABNIRS HB
    case 3  
        nirsdata = NR_nlab_hb2xy([PathName FileName]);
        nirsdata.probeSet = {};
        nirsdata.exception_channel = [];
        subject = FileName(1:end-4);
        nirsdata.subject = subject;
        nirsdata.system = 'SHIMADU LABNIRS';
        nirsdata.probe2d = {};
        dataSource = [PathName subject '.mat'];
        save(dataSource,'nirsdata');
    
       %% case
end

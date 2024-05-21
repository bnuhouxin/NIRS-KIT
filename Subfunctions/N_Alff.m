function N_Alff(handles)

inpathList = get(handles.inpathList,'string');
outpath = get(handles.outpath,'string');
%% ======================== caculate alff ========================
h_wait = waitbar(0, 'Please wait... ');

% calculate alff/malff/zalff
files = dir(fullfile(inpathList,'*.mat'));
n = length(files);

for i=1:n
    load(fullfile(inpathList,files(i).name));
    subid=files(i).name(1:end-4);
    
    %indexdata.probeSet = nirsdata.probeSet;
    indexdata.system = nirsdata.system;
    indexdata.subject = nirsdata.subject;
    indexdata.nch = nirsdata.nch;
    indexdata.index_discription = 'alff';
    indexdata.probe2d = nirsdata.probe2d;
    indexdata.probe3d = nirsdata.probe3d;
    if isfield(nirsdata,'exception_channel')
        indexdata.exception_channel = nirsdata.exception_channel;
    else
        indexdata.exception_channel = zeros(1,nirsdata.nch);
    end
    
    samplingT = nirsdata.T;
    bandlow = str2num(get(handles.bandlow,'string'));
    bandhigh = str2num(get(handles.bandhigh,'string'));
    
    entirelow = str2num(get(handles.entirelow,'string'));
    entirehigh = str2num(get(handles.entirehigh,'string'));
    % ---------------------------------------------------------------------
    % ALFF
    if get(handles.alff,'value')
        
        if get(handles.Oxy,'value')
            [oxy_ALFF,oxy_mALFF,oxy_zALFF] = NR_alff_compute(nirsdata.oxyData,samplingT,bandlow,bandhigh);
            
            oxy_ALFF(indexdata.exception_channel == 1) = NaN;
            oxy_mALFF(indexdata.exception_channel == 1) = NaN;
            oxy_zALFF(indexdata.exception_channel == 1) = NaN;
            
            indexdata.index_discription = 'alff';
            indexdata.index=oxy_ALFF;
            outpathn=fullfile(outpath,'Oxy','ALFF');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
            
%             if get(handles.isAlff_m,'value')
%                 indexdata.index=oxy_mALFF;
%                 outpathn=fullfile(outpath,'Oxy','mALFF');warning off;mkdir(outpathn);
%                 save(fullfile(outpathn,subid),'indexdata');
%             end
            
            if get(handles.isAlff_z,'value')
                indexdata.index_discription = 'zalff';
                indexdata.index=oxy_zALFF;
                outpathn=fullfile(outpath,'Oxy','zALFF');warning off;mkdir(outpathn);
                save(fullfile(outpathn,subid),'indexdata');
            end
        end
        
        if get(handles.Dxy,'value')
            [dxy_ALFF,dxy_mALFF,dxy_zALFF] = NR_alff_compute(nirsdata.dxyData,samplingT,bandlow,bandhigh);
   
            dxy_ALFF(indexdata.exception_channel == 1) = NaN;
            dxy_mALFF(indexdata.exception_channel == 1) = NaN;
            dxy_zALFF(indexdata.exception_channel == 1) = NaN;
            
            indexdata.index_discription = 'alff';
            indexdata.index=dxy_ALFF;
            outpathn=fullfile(outpath,'Dxy','ALFF');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
            
%             if get(handles.isAlff_m,'value')
%                 indexdata.index=dxy_mALFF;
%                 outpathn=fullfile(outpath,'Dxy','mALFF');warning off;mkdir(outpathn);
%                 save(fullfile(outpathn,subid),'indexdata');
%             end
            
            if get(handles.isAlff_z,'value')
                indexdata.index_discription = 'zalff';
                indexdata.index=dxy_zALFF;
                outpathn=fullfile(outpath,'Dxy','zALFF');warning off;mkdir(outpathn);
                save(fullfile(outpathn,subid),'indexdata');
            end
        end
        
        if get(handles.Total,'value')
            [total_ALFF,total_mALFF,total_zALFF] = NR_alff_compute(nirsdata.totalData,samplingT,bandlow,bandhigh);
            
            total_ALFF(indexdata.exception_channel == 1) = NaN;
            total_mALFF(indexdata.exception_channel == 1) = NaN;
            total_zALFF(indexdata.exception_channel == 1) = NaN;
            
            indexdata.index_discription = 'alff';
            indexdata.index=total_ALFF;
            outpathn=fullfile(outpath,'Total','ALFF');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
            
%             if get(handles.isAlff_m,'value')
%                 indexdata.index=total_mALFF;
%                 outpathn=fullfile(outpath,'Total','mALFF');warning off;mkdir(outpathn);
%                 save(fullfile(outpathn,subid),'indexdata');
%             end
            
            if get(handles.isAlff_z,'value')
                indexdata.index_discription = 'zalff';
                indexdata.index=total_zALFF;
                outpathn=fullfile(outpath,'Total','zALFF');warning off;mkdir(outpathn);
                save(fullfile(outpathn,subid),'indexdata');
            end
        end
    end
    % ---------------------------------------------------------------------
    % falff
    if get(handles.falff,'value')
        
        if get(handles.Oxy,'value')
%             [oxy_fALFF,oxy_mfALFF,oxy_zfALFF] = NR_falff_compute(nirsdata.oxyData,samplingT,bandlow,bandhigh,entirelow,entirehigh);
            [oxy_fALFF,oxy_mfALFF,oxy_zfALFF] = NR_falff_compute(nirsdata.oxyData,samplingT,bandlow,bandhigh);
            
            oxy_fALFF(indexdata.exception_channel == 1) = NaN;
            oxy_mfALFF(indexdata.exception_channel == 1) = NaN;
            oxy_zfALFF(indexdata.exception_channel == 1) = NaN;
            
            indexdata.index_discription = 'falff';
            indexdata.index=oxy_fALFF;
            outpathn=fullfile(outpath,'Oxy','fALFF');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
            
%             if get(handles.isfAlff_m,'value')
%                 indexdata.index=oxy_mfALFF;
%                 outpathn=fullfile(outpath,'Oxy','mfALFF');warning off;mkdir(outpathn);
%                 save(fullfile(outpathn,subid),'indexdata');
%             end
            
            if get(handles.isfAlff_z,'value')
                indexdata.index_discription = 'zfalff';
                indexdata.index=oxy_zfALFF;
                outpathn=fullfile(outpath,'Oxy','zfALFF');warning off;mkdir(outpathn);
                save(fullfile(outpathn,subid),'indexdata');
            end
        end
        
        if get(handles.Dxy,'value')
%             [dxy_fALFF,dxy_mfALFF,dxy_zfALFF] = NR_falff_compute(nirsdata.dxyData,samplingT,bandlow,bandhigh,entirelow,entirehigh);
            [dxy_fALFF,dxy_mfALFF,dxy_zfALFF] = NR_falff_compute(nirsdata.dxyData,samplingT,bandlow,bandhigh);
            
            dxy_fALFF(indexdata.exception_channel == 1) = NaN;
            dxy_mfALFF(indexdata.exception_channel == 1) = NaN;
            dxy_zfALFF(indexdata.exception_channel == 1) = NaN;
            
            indexdata.index_discription = 'falff';
            indexdata.index=dxy_fALFF;
            outpathn=fullfile(outpath,'Dxy','fALFF');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
            
%             if get(handles.isfAlff_m,'value')
%                 indexdata.index=dxy_mfALFF;
%                 outpathn=fullfile(outpath,'Dxy','mfALFF');warning off;mkdir(outpathn);
%                 save(fullfile(outpathn,subid),'indexdata');
%             end
            
            if get(handles.isfAlff_z,'value')
                indexdata.index_discription = 'zfalff';
                indexdata.index=dxy_zfALFF;
                outpathn=fullfile(outpath,'Dxy','zfALFF');warning off;mkdir(outpathn);
                save(fullfile(outpathn,subid),'indexdata');
            end
        end
        
        
        if get(handles.Total,'value')
%             [total_fALFF,total_mfALFF,total_zfALFF] = NR_falff_compute(nirsdata.totalData,samplingT,bandlow,bandhigh,entirelow,entirehigh);
            [total_fALFF,total_mfALFF,total_zfALFF] = NR_falff_compute(nirsdata.totalData,samplingT,bandlow,bandhigh);
            
            total_fALFF(indexdata.exception_channel == 1) = NaN;
            total_mfALFF(indexdata.exception_channel == 1) = NaN;
            total_zfALFF(indexdata.exception_channel == 1) = NaN;
            
            indexdata.index_discription = 'falff';
            indexdata.index=total_fALFF;
            outpathn=fullfile(outpath,'Total','fALFF');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
            
%             if get(handles.isfAlff_m,'value')
%                 indexdata.index=total_mfALFF;
%                 outpathn=fullfile(outpath,'Total','mfALFF');warning off;mkdir(outpathn);
%                 save(fullfile(outpathn,subid),'indexdata');
%             end
            
            if get(handles.isfAlff_z,'value')
                indexdata.index_discription = 'zfalff';
                indexdata.index=total_zfALFF;
                outpathn=fullfile(outpath,'Total','zfALFF');warning off;mkdir(outpathn);
                save(fullfile(outpathn,subid),'indexdata');
            end
        end
        
    end
    
    waitbar(i/length(files), h_wait, 'Calculating Alff & FAlff ... ...');
end

waitbar(1, h_wait, 'Alff & FAlff calculating finished !');
pause(1);
close(h_wait);
end

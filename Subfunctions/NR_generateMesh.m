function NR_generateMesh(handles)
    % generate mesh acorrding to siez N

    % define buttonsize,button
    N = str2num(get(handles.meshN,'String'));
    isShowProgress = 0;
    if N > 15
        isShowProgress = 1;
    end
    if isShowProgress
        h_wait = waitbar(0, 'Please wait... ');
    end
    m=50;    
    ButtonSize = m/(N*m+N+1);
    PatchSize = 1/(N*m+N+1);
%     ButtonSizeX = m/(columnNumber*m+columnNumber+1);
%     ButtonSizeY = m/(rowNumber*m+rowNumber+1);
%     ButtonSizeMin = min(ButtonSizeX,ButtonSizeY);
%     ButtonSize=[3/5*ButtonSizeMin,ButtonSizeMin];
%     columnPatch=1/(columnNumber*m+columnNumber+1); rowPatch=1/(rowNumber*m+rowNumber+1);
%     patch = min(columnPatch,rowPatch);
    %layout
    LeftbottomPositon=[];meshN = zeros(N,N);
    for i=1:N
        for j=1:N
            LeftbottomPositon=[LeftbottomPositon; PatchSize*j+ButtonSize*(j-1),PatchSize*(N-i+1)+ButtonSize*(N-i)];
        end
    end
    meshBoxHandle = handles.meshBox;
    buttonHandles=[];
    for i= 1:size(LeftbottomPositon,1) 
        pbh = uicontrol(meshBoxHandle,'Style','pushbutton',...
                    'Units','normalize',...
                    'String','',...
                    'foregroundcolor',[1 1 1],'backgroundcolor',[1 1 1],...
                    'Position',[LeftbottomPositon(i,1),LeftbottomPositon(i,2), ButtonSize,ButtonSize]);
        buttonHandles=[buttonHandles,pbh];
        if isShowProgress
            waitbar(i/size(LeftbottomPositon,1), h_wait, 'Please wait ... ...');
        end
    end
    %fcn connect
    for i=1:length(buttonHandles)
        coli=mod(i,N);
        if(coli==0) coli=N;end;
        set(buttonHandles(i),'Callback', {@ButtonDownFcn,handles,ceil(i/N),coli},'string','');
%         waitbar(i/length(buttonHandles), h_wait, 'Please wait ... ...');
    end
    allMatrix = get(handles.probeList,'userdata');
    if 1 == length(allMatrix)
        currentNum = [0,0,0];
    else
        currentNum = NR_findCurrentNumAll(allMatrix);
    end
    set(meshBoxHandle, 'UserData', struct('buttonHandles',buttonHandles,'meshN',meshN,'currentNum',currentNum));
    if isShowProgress
        waitbar(1, h_wait, 'OK!');
        close(h_wait);
    end

end



function ButtonDownFcn(obj,eventdata,handles,rowi,coli)
    channelNumber = str2num(get(obj,'String'));
    channelColor = get(obj,'backgroundcolor');
    meshBoxData = get(handles.meshBox,'UserData');
    buttonHandles = meshBoxData.buttonHandles;
    meshN = meshBoxData.meshN;
    allMatrix = get(handles.probeList,'userdata');
    probeList = get(handles.probeList,'string');
    isChange = false;
    % step1£ºcolor
    if strcmp(get(handles.doneColor,'enable'),'on')
        isChange = true;
        if 0 == meshN(rowi,coli)      % color
            if get(handles.source,'value')
                set(obj,'backgroundcolor','r');
                meshN(rowi,coli) = -1000;
            end
            if get(handles.detector,'value')
                set(obj,'backgroundcolor','b');
                meshN(rowi,coli) = -2000;
            end
            if get(handles.channel,'value')
                set(obj,'backgroundcolor','g');
                meshN(rowi,coli) = 1000;
            end
        else % 
            if -1000 == meshN(rowi,coli) || -2000 == meshN(rowi,coli) || 1000 == meshN(rowi,coli);
                set(obj,'backgroundcolor',[1 1 1]);
                meshN(rowi,coli) = 0;
            end
        end
    else
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if 1 == channelColor(1) && 0 == channelColor(2) && 0 == channelColor(3)  % red,source
                defAns = meshBoxData.currentNum(1) + 1;
                curNum = inputdlg('Enter detector number','',1,{num2str(defAns)});
                if ~isempty(curNum)  % OK
                    curNum = cell2mat(curNum);
                    if isempty(curNum)
                        set(obj,'String','');
                        meshN(rowi,coli) = -1000;
                        if meshBoxData.currentNum(1) > 0
                            meshBoxData.currentNum(1) = meshBoxData.currentNum(1)-1;
                        end
                    else
                        [rowK,colK] = find(meshN == -str2num(curNum) - 1000);
                        if ~isempty(rowK)
                            if rowK ~= rowi || colK ~= coli
                                h = errordlg(['There is a repeated number in' ', Row ' num2str(rowK) ', Column ' num2str(colK)], 'Error Dialog');
                                waitfor(h);
                                t = timer('TimerFcn',{@flashButtonFcn,meshBoxData,rowK,colK},'ExecutionMode','singleShot');
                                start(t);
                            end
                        else
                            if (iscell(allMatrix) && length(allMatrix)>1)
                                for i=1:length(allMatrix)
                                    [rowK,colK] = find( allMatrix{i} == -str2num(curNum) - 1000 );
                                    if ~isempty(rowK)
                                        errordlg(['There is a repeated number in probe ' probeList{i} ', Row ' num2str(rowK) ', Column ' num2str(colJ)], 'Error Dialog');
                                        break;
                                    end
                                end
                            end
                        end
                        if isempty(rowK)
                            set(obj,'String',curNum,'foregroundcolor',[1 1 1]);
                            meshN(rowi,coli) = -str2num(curNum) - 1000;
                            meshBoxData.currentNum(1) = str2num(curNum);
                        end
                    end  % empty or a number? end
                end   % OK or Cancel? end
            end  % channel press color? end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% blue,detector
            if 0 == channelColor(1) && 0 == channelColor(2) && 1 == channelColor(3)
                defAns = meshBoxData.currentNum(3) + 1;
                curNum = inputdlg('Enter detector number','',1,{num2str(defAns)});
                if ~isempty(curNum)  % OK
                    curNum = cell2mat(curNum);
                    if isempty(curNum)
                        set(obj,'String','');
                        meshN(rowi,coli) = -2000;
                        if meshBoxData.currentNum(2) > 0
                            meshBoxData.currentNum(3) = meshBoxData.currentNum(3)-1;
                        end
                    else
                        [rowK,colK] = find(meshN == -str2num(curNum)-2000);
                        if ~isempty(rowK)
                            if rowK ~= rowi || colK ~= coli
                                h = errordlg(['There is a repeated number in' ', Row ' num2str(rowK) ', Column ' num2str(colK)], 'Error Dialog');
                                waitfor(h);
                                t = timer('TimerFcn',{@flashButtonFcn,meshBoxData,rowK,colK},'ExecutionMode','singleShot');
                                start(t);
                            end
                        else
                            if (iscell(allMatrix) && length(allMatrix)>1)
                                for i=1:length(allMatrix)
                                    [rowK,colK] = find( allMatrix{i} == -str2num(curNum)-2000 );
                                    if ~isempty(rowK)
                                        errordlg(['There is a repeated number in probe ' probeList{i} ', Row ' num2str(rowK) ', Column ' num2str(colK)], 'Error Dialog');
                                        break;
                                    end
                                end
                            end
                        end
                        if isempty(rowK)
                            set(obj,'String',curNum,'foregroundcolor',[1 1 1]);
                            meshN(rowi,coli) = -str2num(curNum) - 2000;
                            meshBoxData.currentNum(3) = str2num(curNum);
                        end
                    end
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% green,channel
            if 0 == channelColor(1) && 1 == channelColor(2) && 0 == channelColor(3)
                defAns = meshBoxData.currentNum(2) + 1;
                curNum = inputdlg('Enter channel number','',1,{num2str(defAns)});
                if ~isempty(curNum)  % OK or Cancel? OK
                    curNum = cell2mat(curNum);
                    if isempty(curNum) % empty or a number? empty, means delete
                        set(obj,'String','');
                        meshN(rowi,coli) = 1000;
                        if meshBoxData.currentNum(2) > 0
                            meshBoxData.currentNum(2) = meshBoxData.currentNum(2)-1;
                        end
                    else % with a number
                        % check repeated
                        [rowK,colK] = find(meshN == str2num(curNum)+1000);  % find repeated number in current mesh
                        if ~isempty(rowK)
                            if rowK ~= rowi || colK ~= coli
                                h = errordlg(['There is a repeated number in' ' row ' num2str(rowK) ', column ' num2str(colK)], 'Error Dialog');
                                waitfor(h);
                                t = timer('TimerFcn',{@flashButtonFcn,meshBoxData,rowK,colK},'ExecutionMode','singleShot');
                                start(t);
                            end
                        else
                            if (iscell(allMatrix) && length(allMatrix)>1)
                                for i=1:length(allMatrix)
                                    [rowK,colK] = find( allMatrix{i} == str2num(curNum)+1000 );
                                    if ~isempty(rowK)
                                        errordlg(['There is a repeated number in probe ' probeList{i} ', Row ' num2str(rowK) ', Column ' num2str(colK)], 'Error Dialog');
                                        break;
                                    end
                                end
                            end
                        end
                        % no repeated, do set
                        if isempty(rowK)
                            set(obj,'String',curNum,'foregroundcolor','k');
                            meshN(rowi,coli) = str2num(curNum) + 1000;
                            meshBoxData.currentNum(2) = str2num(curNum);
                        end
                    end % empty or a number? end
                end  % % OK or Cancel? end
            end  % channel press color? end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    meshBoxData.meshN = meshN;
    set(handles.meshBox,'UserData',meshBoxData);
    % set data to probe list
    k = get(handles.probeList,'value');
    allMatrix = get(handles.probeList,'userdata');
    allMatrix{k} = meshBoxData.meshN;
    set(handles.probeList,'userdata',allMatrix);
    if isChange
        set(handles.save,'userdata',false);
    end
end



function flashButtonFcn(obj, event, meshBoxData, rowK,colK)
    buttonHandles = meshBoxData.buttonHandles;
    meshN = meshBoxData.meshN;
    repetButtonHandle = buttonHandles((rowK-1)*length(meshN)+colK);
    originalColor = get(repetButtonHandle,'backgroundcolor');
    nFactorial = 3;
    while nFactorial>0
        set(repetButtonHandle,'backgroundcolor',[1 1 1]);
        pause(0.15);
        repetButtonHandle = buttonHandles((rowK-1)*length(meshN)+colK);
        set(repetButtonHandle,'backgroundcolor',originalColor);
        nFactorial = nFactorial -1;
        pause(0.15);
    end
end

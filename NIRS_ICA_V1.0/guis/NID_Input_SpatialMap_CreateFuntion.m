function NID_Input_SpatialMap_CreateFuntion(handles)
%%
% �ú������ڡ��ռ�ģ�����ý��� NID_Input_SpatialMap��
% ������ģ����ʾ����channel_pannel�������⼫��������Ϣ���Ա���һ��ģ�������
%% load data
obj = findobj('Tag','NIRS_ICA_Denoiser');
openfileHandles = guihandles(obj);
datapath = get(openfileHandles.listbox1,'UserData');
data = load(datapath);
nirsdata = data.nirsdata;
%%
% generate button pannel��ֱ�Ӽ̳�NIRS_REST��
    N = nirsdata.nch;
    Row = floor(N/10);
    maxM = 6;
    maxN = 10;
    Ratio = 6; 
    ButtonSize=[Ratio*1/(maxN*Ratio+maxN+1),Ratio*1/(maxM*Ratio+maxM+1)];
    GapSize=[1/(maxN*Ratio+maxN+1),1/(maxM*Ratio+maxM+1)];
    
%     probe2d = nirsdata.probe2d;
    if ~isfield(nirsdata,'probe2d')
        LeftbottomPositon=[];
        for i = 1:Row
            for j = 1:10
                newPosition = [(GapSize(1)+ButtonSize(1))*(j-1)+ GapSize(1), 1-(GapSize(2)+ButtonSize(2))*i];
                LeftbottomPositon=[LeftbottomPositon;  newPosition ];
            end
        end
        i = Row+1;
        for j = 1:N-10*Row;
            newPosition=[(GapSize(1)+ButtonSize(1))*(j-1)+ GapSize(1), 1-(GapSize(2)+ButtonSize(2))*i];
            LeftbottomPositon=[LeftbottomPositon;  newPosition ];
        end
        handles_button = NID_buttons_create(handles.channel_pannel, handles, LeftbottomPositon, ButtonSize, @NID_channelControl_InputSpatialMap);
        set(handles.channel_pannel,'UserData',handles_button);
%         set(handles_button(1),'BackgroundColor',[0.7,0.7,1]);
    else
    % probe merge
        mergeprobe=[];
        probe2d = nirsdata.probe2d;
        for i = 1:length(probe2d)
            tprobe=probe2d{i}.probeSet;
            % probe cut edge
            rowlr=getleftright(sum(tprobe>1000,2));
            collr=getleftright(sum(tprobe>1000,1));
            tprobe=tprobe(rowlr(1):rowlr(2),collr(1):collr(2));
            mergeprobe(1:size(tprobe,1), size(mergeprobe,2)+1:size(mergeprobe,2)+size(tprobe,2))=tprobe;
            mergeprobe(:,end+1)=0;
        end
%         mergeprobe=mergeprobe(:,1:end-1);
    % init
        maxM = size(mergeprobe,1);
        maxN = size(mergeprobe,2);
        Ratio = 6; 
        ButtonSize=[Ratio*1/(maxN*Ratio+maxN+1),Ratio*1/(maxM*Ratio+maxM+1)];
        GapSize=[1/(maxN*Ratio+maxN+1),1/(maxM*Ratio+maxM+1)];
    % draw
        LeftbottomPositon=[];
%         beishu=1.75;
%         x=(1+Ratio-Ratio*beishu)/2;
        for id = 1:N
            [i,j]=find(mergeprobe==1000+id);
            newPosition = [(GapSize(1)+ButtonSize(1))*(j-1)+ 2*GapSize(1), 1-(GapSize(2)+ButtonSize(2))*i];
            LeftbottomPositon=[LeftbottomPositon;  newPosition ];
        end
        ButtonSize(1) = ButtonSize(1)*1.75;
        handles_button = NID_buttons_create(handles.channel_pannel, handles, LeftbottomPositon, ButtonSize, @NID_channelControl_InputSpatialMap);
        set(handles.channel_pannel,'UserData',handles_button);
%         set(handles_button(1),'BackgroundColor',[0.7,0.7,1]);        
    end
end

function lr=getleftright(array)
    lr=[length(array),1];
    for i=1:length(array)
        if(array(i)>0)
            lr(1)=i;
            break;
        end
    end
    for i=length(array):-1:1
        if(array(i)>0)
            lr(2)=i;
            break;
        end
    end
end
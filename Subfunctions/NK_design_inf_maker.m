function NK_design_inf_maker

clear;clc;

handles(1) = figure('units','norm','position',[.4,.3,.2,.45],'name','Design_Inf_Maker','menubar','none','numbertitle','off','color',[.941,.941,.941]);
handles(2) = uipanel('units','norm','title','Data Source','fontSize',10,'Position',[.05,.8775,.9,.1]);
handles(3) = uicontrol('units','norm','parent',handles(2),'style','text','string','Input path:','Position',[.0,.2,.15,.575]);
handles(4) = uicontrol('units','norm','parent',handles(2),'style','edit','Position',[.15,.3,.7,.575],'backgroundcolor','w');
handles(5) = uicontrol('units','norm','parent',handles(2),'style','pushbutton','string','бн','Position',[.875,.3,.1,.575]);
handles(6) = uipanel('units','norm','title','Desig_Inf','fontSize',10,'Position',[.05,.1,.9,.75]);
handles(7) = uicontrol('units','norm','parent',handles(1),'style','pushbutton','string','Run','Position',[.8,.025,.15,.05]);
handles(8) = uicontrol('units','norm','parent',handles(1),'style','pushbutton','string','Marker Display','Position',[.05,.025,.175,.05]);

% global handles_buttons label

set(handles(5),'callback', {@add_path,handles},'backgroundColor',[.941,.941,.941]);
set(handles(8),'callback', {@add_path,handles},'backgroundColor',[.941,.941,.941]);

end



function add_path(hObject, eventdata, handles)
    inpath = uigetdir;
    if ischar(inpath)
        set(handles(4),'string',inpath);
        
        inpath = get(handles(4),'string');
        sublist = dir(fullfile(inpath,'*.mat'));
        
        if ~isempty(sublist)
            load(fullfile(inpath,sublist(1).name));
            markers = unique(nirsdata.vector_onset);
            markers = setdiff(markers,0);
            
            label(1) = uicontrol('units','norm','parent',handles(6),'style','pushbutton','string','marker',...
                 'position',[.025,.9, .2,.075],'enable','inactive');
            label(2) = uicontrol('units','norm','parent',handles(6),'style','pushbutton','string','onset/end',...
                'position',[.25,.9, .2,.075],'enable','inactive');
            label(3) = uicontrol('units','norm','parent',handles(6),'style','pushbutton','string','cond name',...
                'position',[.475,.9, .2,.075],'enable','inactive');
            label(4) = uicontrol('units','norm','parent',handles(6),'style','pushbutton','string','duration',...
                'position',[.70,.9, .2,.075],'enable','inactive');
            label(5) = uicontrol('units','norm','parent',handles(6),'style','pushbutton','string','unit',...
                'position',[.9,.9, .075,.075],'userdata','scan');


            handles_buttons = cell(1,5);
            for i= 1:length(markers)
                handles_buttons{1,1}(i,1) = uicontrol('units','norm','parent',handles(6),'style','text','string',['marker = ', num2str(i)],...
                    'position',[.025,.8-.085*(i-1),.2,.05]);

                handles_buttons{1,2}(i,1) = uicontrol('units','norm','parent',handles(6),'style','popupmenu','string',strvcat('onset','end','onset & end'),...
                    'position',[.25,.8125-.085*(i-1),.2,.05]);
                
                handles_buttons{1,3}(i,1) = uicontrol('units','norm','parent',handles(6),'style','edit',...
                    'position',[.475,.8-.085*(i-1),.2,.075],'backgroundcolor','w');
                
                handles_buttons{1,4}(i,1) = uicontrol('units','norm','parent',handles(6),'style','edit',...
                    'position',[.7,.8-.085*(i-1),.2,.075],'backgroundcolor','w');
                
                handles_buttons{1,5}(i,1) = uicontrol('units','norm','parent',handles(6),'style','text','string','scan',...
                    'position',[.9,.8-.085*(i-1),.075,.05]);
                
                
            end
            
            for i= 1:length(markers)
                set(handles_buttons{1,2}(i,1),'Callback', {@marker_ch,handles,handles_buttons,i});
            end
            
            
            set(label(5),'Callback', {@unit_ch,handles,handles_buttons,label},'BackgroundColor',[0.941,0.941,0.941]);
            
        end
        set(handles(7),'callback',{@run_maker,handles,handles_buttons,label},'backgroundColor',[.941,.941,.941]);
        set(handles(8),'callback', {@marker_display,handles},'backgroundColor',[.941,.941,.941]);
    end         
end

function marker_display(hObject, eventdata, handles)

    inpath = get(handles(4),'string');
    if ischar(inpath)
        [file,path] = uigetfile('*.mat','Select a sample subject',inpath);
    else
        [file,path] = uigetfile('*.mat','Select a sample subject');
    end
    
    if ischar(file)
        load(fullfile(path,file));
        
        markers = unique(nirsdata.vector_onset);
        markers = setdiff(markers,0);

        color = colormap(jet(length(markers)));

        % try
        %     color = colormap(parula(length(markers)));
        % catch
        %     color = colormap(jet(length(markers)));
        % end

        figure('Name',['Marker Display [',file(1:end-4),']'],'Color',[1 1 1]);

        for ii = 1:length(markers)
            marker_tp = find(nirsdata.vector_onset == markers(ii));
            hold on;

            for jj = 1:length(marker_tp)
                plot([marker_tp(jj),marker_tp(jj)],[0,markers(ii)],'color',color(ii,:),'LineWidth',2);
            end
            
        end

        xlim=get(gca,'xlim');
        xlim(1)=0;
        set(gca,'xlim',xlim);

        set(gca,'ygrid','on');
        set(gca,'box','on');
        xlabel('Time (scans)','FontSize', 10); ylabel('Markers','FontSize', 10); 
    end

end


function unit_ch(hObject, eventdata, handles,handles_buttons,label)

    unit_ty = get(handles_buttons{1,5}(1,1),'string');

    if strcmp(unit_ty,'scan')
        set(label(5),'userdata','s');
        for j = 1:length(handles_buttons{1,5})
           set(handles_buttons{1,5}(j,1),'string','s');
        end
    elseif strcmp(unit_ty,'s')
        set(label(5),'userdata','scan');
        for j = 1:length(handles_buttons{1,5})
           set(handles_buttons{1,5}(j,1),'string','scan');
        end
    end

end


function marker_ch(hObject, eventdata, handles,handles_buttons,i)

    mark_ty = get(handles_buttons{1,2}(i,1),'value');

    if mark_ty == 1
        if strcmp(get(handles_buttons{1,3}(i,1),'enable'),'off')
            set(handles_buttons{1,3}(i,1),'string','','enable','on');
        end

        if strcmp(get(handles_buttons{1,4}(i,1),'enable'),'off')
            for j = 1:length(handles_buttons{1,4})
                buttons_state(j,1) = get(handles_buttons{1,2}(j,1),'value');
            end
            if  isempty(find(buttons_state==2)) & isempty(find(buttons_state==3))
                for j = 1:length(handles_buttons{1,4})
                    set(handles_buttons{1,4}(j,1),'string','','enable','on');
                end
            end

        end

    elseif mark_ty == 2
        if strcmp(get(handles_buttons{1,3}(i,1),'enable'),'on')
            set(handles_buttons{1,3}(i,1),'string','','enable','off');
            for j = 1:length(handles_buttons{1,4})
                if strcmp(get(handles_buttons{1,4}(j,1),'enable'),'on')
                    set(handles_buttons{1,4}(j,1),'string','','enable','off');
                end
            end
        end
    elseif mark_ty == 3
        if strcmp(get(handles_buttons{1,3}(i,1),'enable'),'off')
            set(handles_buttons{1,3}(i,1),'string','','enable','on');

        end   
        if strcmp(get(handles_buttons{1,4}(i,1),'enable'),'on')
            set(handles_buttons{1,4}(i,1),'string','','enable','off');
        end
    end

end


function run_maker(hObject, eventdata, handles,handles_buttons,label)

    inpath = get(handles(4),'string');
    sublist = dir(fullfile(inpath,'*.mat'));

    design_inf{1,1} = 'SubID\ConditionName';
    
    for i = 1:length(handles_buttons{1,1})
        mark_inf{i,1} = get(handles_buttons{1,1}(i,1),'string');
        mark_inf{i,2} = get(handles_buttons{1,2}(i,1),'value');
        mark_inf{i,3} = get(handles_buttons{1,3}(i,1),'string');
        mark_inf{i,4} = get(handles_buttons{1,4}(i,1),'string');
        mark_inf{i,5} = get(handles_buttons{1,5}(i,1),'string');
    end
   
   cond_name = {}; 
   end_marker = [];
   for i = 1:size(mark_inf,1)
       if mark_inf{i,2} ~= 2
           if i == 1
               cond_name(1,1) = mark_inf(i,3);
           else
               if all(ismember(cond_name(1,:),mark_inf(i,3)) == 0)
                   cond_name = [cond_name,mark_inf{i,3}];
               end
           end
       elseif mark_inf{i,2} == 2
           end_marker = [end_marker;i];
       end
   end
    
   design_inf(1,2:1+size(cond_name,2)) = cond_name;
   
   
   for sub = 1:length(sublist)
      load(fullfile(inpath,sublist(sub).name)); 
      
      markers = unique(nirsdata.vector_onset);
      markers = setdiff(markers,0);
      if size(markers,1) ~= size(mark_inf,1)
          warndlg(['Markers number of the current subject [',sublist(sub).name,'] is not equal to others !!!'],'Warning');
          disp(['-----------  Markers number of the current subject [',sublist(sub).name,'] is not equal to others !!! -----------']);
      end
          
      design_inf{sub+1,1} = sublist(sub).name(1:end-4);
      
      if ~isempty(end_marker)
         marker_end = [];
         for j = 1:length(end_marker)
             end_tp = find(nirsdata.vector_onset == end_marker(j));
             marker_end = [marker_end;end_tp];
         end
         marker_end = sort(marker_end);
         
         marker_onset =  setdiff(markers,end_marker);
         onset_ty = [];
         for k = 1:length(marker_onset)
             onset_sub = find(nirsdata.vector_onset == marker_onset(k));
             onset_ty = [onset_ty;onset_sub];
         end
         onset_ty = sort(onset_ty);
         
         if length(marker_end) ~= length(onset_ty)
             warndlg({'The number of onsets is not equal to the number of ends'; ['when [', sublist(sub).name, '] was processing !!!'];'';'Please check !!!'},'Warning');
             disp(['-------- The number of onsets is not equal to the number of ends','when ', sublist(sub).name, ' was processing !!! --------']);
         else
             [~,bt] = sort([onset_ty;marker_end]);
             if bt(2:2:end) ~= bt(1:2:end)+length(onset_ty)
                 warndlg({'The marker orders of onsets and ends are not correct'; ['when [', sublist(sub).name, '] was processing !!!'];'';'Please check !!!'},'Warning');
                 disp(['--------- The marker orders of onsets and ends are not correct','when ', sublist(sub).name, ' was processing !!! ---------']);
             else
                 marker_onset_end = [onset_ty,marker_end];
                 marker_onset_end(:,3) = marker_end-onset_ty;
             end
             
         end       
      end
       
      for cond_num = 1:length(cond_name)
          cond_mark = ismember(mark_inf(:,3),cond_name(cond_num));
          mark_num = find(cond_mark == 1);
          cond_onset_dur = [];
          
          for ii = 1:length(mark_num)
              mark_onset_dur = [];
              if mark_inf{mark_num(ii),2} == 1
                  mark_onset_dur(:,1) = find(nirsdata.vector_onset == mark_num(ii));
                  if ~strcmp(mark_inf{mark_num(ii),4},'')
                      if strcmp(mark_inf{mark_num(ii),5},'scan')
                          duration = str2num(mark_inf{mark_num(ii),4});  
                      elseif strcmp(mark_inf{mark_num(ii),5},'s')
                          duration = str2num(mark_inf{mark_num(ii),4})./nirsdata.T;
                      end
                      mark_onset_dur(:,2) = duration;
                  elseif strcmp(mark_inf{mark_num(ii),4},'')
                      for bk_num = 1:size(mark_onset_dur,1)
                         bk_ch = find(marker_onset_end(:,1) == mark_onset_dur(bk_num,1));
                         if isempty(bk_ch)
                             warndlg(['There was something wrong,when [', sublist(sub).name, '] was processing !!!'],'Warning');
                             disp(['----------- There was something wrong,when [', sublist(sub).name, '] was processing !!! -----------']);
                         else
                             mark_onset_dur(bk_num,2) = marker_onset_end(bk_ch,3);
                         end
                      end
                  end
                  
                  cond_onset_dur = [cond_onset_dur;mark_onset_dur];
              elseif mark_inf{mark_num(ii),2} == 3
                  onset_end = find(nirsdata.vector_onset == mark_num(ii));
                  if mod(length(onset_end),2) ~= 0
                      warndlg(['There was something wrong,when [', sublist(sub).name, '] was processing !!!'],'Warning');
                      disp({['----------- There was something wrong,when [', sublist(sub).name, '] was processing !!! -----------'];...
                          '------------- Please check the number of [mark type = onset & end] for this subject !!! -------------'});
                  else
                      mark_onset_dur(:,1) = onset_end(1:2:end);
                      mark_onset_dur(:,2) = onset_end(2:2:end) - mark_onset_dur(:,1);

                      cond_onset_dur = [cond_onset_dur;mark_onset_dur];
                  end
              end
          end
          cond_onset_dur = sortrows(cond_onset_dur);
          design_inf{sub+1,cond_num+1} = cond_onset_dur;
      end
  
   end
   
   [file,path] = uiputfile('design_inf.mat','Save File');
   save(fullfile(path,file),'design_inf');

end
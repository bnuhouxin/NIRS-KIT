function gii3d_id=NR_plot3dgii(handles)

% MNI position and CData --------------------------------------------------
inpath_xls=get(handles.inpath3d,'string');
type = get(handles.shown_type_3d,'value');
h3d=waitbar(0,'Please wait ... ...');


[~,~,xls_data]=xlsread(inpath_xls);
xls_data = xls_data(2:end,:);
xls_data = cell2mat(xls_data);
waitbar(2/10,h3d);


Position=xls_data(:,2:4);
CData=xls_data(:,5); % activation values or ALFF/fALFF values


if type == 1 % plot withinin matlab on brain surface
    r_sph=str2num(get(handles.circle_size_3d,'string'));

    Cmin=str2num(get(handles.climt_min_3d,'string'));
    Cmax=str2num(get(handles.climt_max_3d,'string'));
    
    % read template.gii -------------------------------------------------------
    gii_path=get(handles.temp_nii_gii_file,'userdata');
    gii_name=get(handles.temp_nii_gii_file,'string');
    % template_mesh = gifti(fullfile(gii_path,gii_name));
    load(fullfile(gii_path,gii_name));

    vertices=template_mesh.vertices;
    faces=template_mesh.faces;

    waitbar(4/10,h3d);

    % Index -------------------------------------------------------------------
    kept_face=[];
    kept_face_cdata=[];

    for i=1:size(Position,1)

        current_mni=Position(i,:);
        % distance to peak position
        dist=sqrt(sum(bsxfun(@minus,vertices,current_mni).^2,2));

        % extract nodes closer than  mm, and belonging to tetrahedra with region
        m_gm.nodes=vertices;
        m_gm.triangles=faces;

        node_idx=dist<r_sph;
        m_ROI=triangles_extract(m_gm,'node_idx', node_idx);

        idx_tmp=m_ROI.idx_kept_tri;
        kept_face=[kept_face;m_gm.triangles(idx_tmp,:)];

        kept_face_data_tmp=zeros(size(m_gm.triangles(idx_tmp,:),1),1)+CData(i,1);
        kept_face_cdata=[kept_face_cdata;kept_face_data_tmp];

    end

    waitbar(8/10,h3d);

    brain.Vertices=vertices;
    brain.Faces=faces;

    gii3d_id=figure;
    
    if get(handles.Is_scalp,'value')
       scalp_alpha = get(handles.scalp_alpha,'string');
       if ~isempty(scalp_alpha)
           scalp_alpha = str2num(scalp_alpha);
       else
           scalp_alpha = 0.25;
       end
       
       scalp_path = which('scalp_mz3.mat');
       
       if ~isempty(scalp_path)
           load(scalp_path);
       end
           
       patch('Faces',m.faces,'Vertices',m.vertices,'facecolor',[180/255,180/255,180/255],'LineStyle','none');
       hold on;
       alpha(scalp_alpha);    
    end
    
    
    h1=patch(brain,...
        'FaceColor',[0.85,0.85,0.85],...
        'EdgeColor','none');
    material(h1,'dull');

    hold on
    h1=patch('Faces',kept_face,'Vertices',vertices,'FaceVertexCData',kept_face_cdata,...
        'FaceColor','flat','EdgeColor','none','CDataMapping','scaled','FaceAlpha',1);

    axis equal;
    set(gcf,'color',[1 1 1])
    set(gca,'xtick',[],'ytick',[],'ztick',[])
    set(gca,'Ycolor',[1 1 1],'Xcolor',[1 1 1],'Zcolor',[1 1 1]);

    if get(handles.Is_lighting,'value')
        lighting gouraud;
        hlight=camlight('infinit');
%         hlight=camlight('headlight');
        set(gca,'UserData',hlight);
        hrot = rotate3d;
        set(hrot,'ActionPostCallback',@(~,~)camlight(get(gca,'UserData'),'headlight'));
    end

    set(gca,'Clim',[Cmin Cmax]);
    colorbar;

    waitbar(10/10,h3d);
    delete(h3d);
elseif type == 2 % nfri_mni_plot
    r_sph=str2num(get(handles.circle_size_3d,'string'));

    Cmin=str2num(get(handles.climt_min_3d,'string'));
    Cmax=str2num(get(handles.climt_max_3d,'string'));
    
    gii3d_id=[];
    
    InputData.xyzsd = Position;
    InputData.xyzsd(:,4) = r_sph;
    InputData.values = CData;
    InputData.max = Cmax;
    InputData.min = Cmin;
    
    if get(handles.Is_scalp,'value')
       InputData.Is_scalp = 1;
       scalp_alpha = get(handles.scalp_alpha,'string');
       if ~isempty(scalp_alpha)
           InputData.scalp_alpha = str2num(scalp_alpha);
       else
           InputData.scalp_alpha = 0.25;
       end
    else
        InputData.Is_scalp = 0;
        InputData.scalp_alpha = 0.25;
    end
    
    CM = 'jet'; % colormap parula
    nfri_mni_plot(CM, InputData,'simple'); % ---- change to simple plot model
    
    waitbar(10/10,h3d);
    delete(h3d);
    
elseif type == 4 % EasyTopo
    
    mni = Position;
    mni(:,4) = sign(mni(:,1));
    
    right_n = find(mni(:,4) ~= 1);
    
    if ~isempty(right_n)
        mni(right_n,4) = 2;
    end
    
    gii3d_id=figure;
    if get(handles.Is_scalp,'value')
       scalp_alpha = get(handles.scalp_alpha,'string');
       if ~isempty(scalp_alpha)
           scalp_alpha = str2num(scalp_alpha);
       else
           scalp_alpha = 0.25;
       end
       
       scalp_path = which('scalp_mz3.mat');
       
       if ~isempty(scalp_path)
           load(scalp_path);
       end
           
       patch('Faces',m.faces,'Vertices',m.vertices,'facecolor',[180/255,180/255,180/255],'LineStyle','none');
       hold on;
       alpha(scalp_alpha);    
    end
    
    plot3D_brain_inter(mni,CData);
    
    if get(handles.Is_lighting,'value')
        hlight=camlight('headlight');
        set(gca,'UserData',hlight);

        lighting gouraud;

        hrot = rotate3d;
        set(hrot,'ActionPostCallback',@(~,~)camlight(get(gca,'UserData'),'headlight'));
    end
    
    
    set(gca,'Clim',[min(CData), max(CData)]);
    colorbar;
    
    waitbar(10/10,h3d);
    delete(h3d);
end
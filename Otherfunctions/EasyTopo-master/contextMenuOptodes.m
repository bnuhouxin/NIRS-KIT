function  contextMenuOptodes(h,handles)
%Create Context Menus 
    clickMenu = uicontextmenu;
    %Add  Menu Items & Callbacks
    m1 = uimenu(clickMenu,'Label','Open in New Figure', 'Callback', @OpenNewFigure);
    m2 = uimenu(clickMenu,'Label','View Top','Callback',@viewTop);
    m3 = uimenu(clickMenu,'Label','View Front','Callback',@viewFront);
    m4 = uimenu(clickMenu,'Label','View Back','Callback',@viewBack);
    m5 = uimenu(clickMenu,'Label','View Right','Callback',@viewRight);
    m6 = uimenu(clickMenu,'Label','View Left','Callback',@viewLeft);
    
    set(h,'uicontextmenu',clickMenu);
    %Make new figure
	function OpenNewFigure(h,callbackdata)
        newFigure = figure('color','w'); 
        viewangle = [0 0 1];       
        plot3D = plotoptodes(handles.BrainSurface.vertices,handles.BrainSurface.faces,handles.data.mni,3,viewangle);        
        contextMenuOptodes(plot3D,handles);
    end
    %Top view
    function viewTop(h,callbackdata)
        viewangle = [0 0 1];
        axes(gca);
        cla(gca);
        h = plotoptodes(handles.BrainSurface.vertices,handles.BrainSurface.faces,handles.data.mni,3,viewangle);        
        contextMenuOptodes(h,handles);
    end
    %Front view
    function viewFront(h,callbackdata)
        viewangle = [0 1 0];        
        axes(gca);
        cla(gca);
        h = plotoptodes(handles.BrainSurface.vertices,handles.BrainSurface.faces,handles.data.mni,3,viewangle);        
        contextMenuOptodes(h,handles);
    end
    %Back view
    function viewBack(h,callbackdata)
        viewangle = [0 -1 0];
        axes(gca);
        cla(gca);
        h = plotoptodes(handles.BrainSurface.vertices,handles.BrainSurface.faces,handles.data.mni,3,viewangle);        
        contextMenuOptodes(h,handles);
    end
    %Right view
    function viewRight(h,callbackdata)
        viewangle = [1 0 0];        
        axes(gca);
        cla(gca);
        h = plotoptodes(handles.BrainSurface.vertices,handles.BrainSurface.faces,handles.data.mni,3,viewangle);        
        contextMenuOptodes(h,handles);
    end
    %Left view
    function viewLeft(h,callbackdata)
        viewangle  = [-1 0 0];       
        axes(gca);
        cla(gca);
        h = plotoptodes(handles.BrainSurface.vertices,handles.BrainSurface.faces,handles.data.mni,3,viewangle);        
        contextMenuOptodes(h,handles);
    end
end
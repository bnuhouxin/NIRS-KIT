function contextMenuImg(h,vertcolor,handles)
    %Create Context Menus 
    clickMenu = uicontextmenu;
    %Add  Menu Items & Callbacks
    m1 = uimenu(clickMenu,'Label','Open in New Figure', 'Callback', @OpenNewFigure);
    m2 = uimenu(clickMenu,'Label','View Top','Callback',@viewTop);
    m3 = uimenu(clickMenu,'Label','View Front','Callback',@viewFront);
    m4 = uimenu(clickMenu,'Label','View Back','Callback',@viewBack);
    m5 = uimenu(clickMenu,'Label','View Right','Callback',@viewRight);
    m6 = uimenu(clickMenu,'Label','View Left','Callback',@viewLeft);
    colormap(handles.cmap);
    
    set(h,'uicontextmenu',clickMenu);
    %Make new figure
    function OpenNewFigure(h,callbackdata)
        newFigure = figure('color','w');
        viewangle = [0 0 1];
        plot3D = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces,vertcolor,viewangle);
        contextMenuImg(plot3D,vertcolor,handles);
    end
    %Top view
	function viewTop(h,callbackdata)
        viewangle = [0 0 1];
        h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces,vertcolor,viewangle);
        contextMenuImg(h,vertcolor,handles);
    end  
    %Front view
    function viewFront(h,callbackdata)
        viewangle = [0 1 0];
        h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces,vertcolor,viewangle);
        contextMenuImg(h,vertcolor,handles);
    end
    %Back view
    function viewBack(h,callbackdata)
        viewangle = [0 -1 0];
        h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces,vertcolor,viewangle);
        contextMenuImg(h,vertcolor,handles);
    end
    %Right view
    function viewRight(h,callbackdata)
        viewangle = [1 0 0];
        h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces,vertcolor,viewangle);
        contextMenuImg(h,vertcolor,handles);
    end
    %Left view
    function viewLeft(h,callbackdata)
        viewangle  = [-1 0 0];
        h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces,vertcolor,viewangle);
        contextMenuImg(h,vertcolor,handles);
    end
end
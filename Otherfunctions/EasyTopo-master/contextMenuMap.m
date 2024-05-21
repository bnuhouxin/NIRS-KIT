function contextMenuMap(h,map,handles)
    %Create Context Menus 
    clickMenu = uicontextmenu;
    %Add  Menu Items & Callbacks
    m1 = uimenu(clickMenu,'Label','Open in New Figure', 'Callback', @openNewFigure);
    set(h,'uicontextmenu',clickMenu);
    
    function openNewFigure(h,callbackdata)
        figure('color','w');        
        imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-abs(max(map(:))) abs(max(map(:)))]); set(gca,'Ydir','normal');
        hold on; contour(handles.map.phi,handles.map.theta,handles.BrainField,5,'k-','linewidth',1); 
        xlabel('\phi (degree)'); ylabel('\theta (degree)');
        colormap(handles.cmap); colorbar;
    end
end
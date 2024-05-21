function h = plotimage(vertices, faces, vertcolor, viewangle)

    h = plotsurf(vertices, faces, 'edgealpha', 0, 'facecolor', 'interp');
    set(h,'FaceVertexCData',vertcolor, 'SpecularStrength',0, 'AmbientStrength',0.4); 
    daspect([1 1 1]); 
    axis off;
    view(3); view(viewangle); 
    
%     hlight=camlight('headlight');
%     set(gca,'UserData',hlight);
%     
%     lighting gouraud;
%     
%     hrot = rotate3d;
%     set(hrot,'ActionPostCallback',@(~,~)camlight(get(gca,'UserData'),'headlight'));
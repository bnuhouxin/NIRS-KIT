function plotbubble3D(ptsIn,ptRads,cols)

    nPts = size(ptsIn,1);
    [X,Y,Z] = ellipsoid(0,0,0,1,1,1,50);            

    for i = 1:nPts
        hold on
        surface(X*ptRads(i)+ptsIn(i,1),Y*ptRads(i)+ptsIn(i,2),...
            Z*ptRads(i)+ptsIn(i,3),'FaceColor',cols(i,:),'EdgeColor','none');               
    end
%     camlight; lighting phong;

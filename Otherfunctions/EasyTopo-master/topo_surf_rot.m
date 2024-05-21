function vertvalue = topo_surf_rot(mni, value, vertices)

%generate XYZ of vertices
shift = [0 -21 0];      %shift of origin
XYZ = [vertices(:,3)-shift(3) vertices(:,2)-shift(2) vertices(:,1)-shift(1)];

%region-wise interpolation
counter = 0;
%h = waitbar(0,'Loading...'); 
for reg = 1:max(mni(:,4));
      %waitbar(reg/100, h);
    idx = find(mni(:,4)==reg);
    
    if isempty(idx) == 0
        counter = counter+1;
        
        %generate xyz of region-wise data
        xyz = [mni(idx,3)-shift(3) mni(idx,2)-shift(2) mni(idx,1)-shift(1)];
        v = value(idx);
        
        %degree and direction of coordinate rotation
        if mean(mni(idx,1))<0                   
            degree = -50;   %region on left hemisphere
        else
            degree = 50;   %region on right hemisphere    
        end
        
        %coordinate rotation and conversion to spherical system
        xyz_r = xyz_rot(xyz,degree);
        [t,p,r] = cart2sph(xyz_r(:,1),xyz_r(:,2),xyz_r(:,3));
       
        XYZ_r = xyz_rot(XYZ,degree);
        [T,P,R] = cart2sph(XYZ_r(:,1),XYZ_r(:,2),XYZ_r(:,3));
        
        %data interpolation
        V =  griddata(t,p,v,T,P);
        
        if counter == 1
            vertvalue = V;
        else
            vertvalue(~isnan(V)) = V(~isnan(V));
        end
        
        clear xyz v degree xyz_r t p r XYZ_r T P R V
    end
    
    clear idx     
end
%close(h);
clear reg counter XYZ

return



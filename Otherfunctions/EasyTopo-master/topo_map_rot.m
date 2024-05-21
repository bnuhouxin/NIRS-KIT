function [T, P, R, V, region] = topo_map_rot(mni, value)

%shift of origin
shift = [0 -21 0];

%generate [theta,phi] map 
counter_left = 0;
counter_right = 0;
%h = waitbar(0,'Loading...'); 
for reg = 1:max(mni(:,4));
%          idx = zeros(size(value));
%                 for n = 1:size(value)
%                     idx(n) = n;
%                 end
     idx = find(mni(:,4)==reg);
    if isempty(idx) == 0
        
        %generate xyz of region-wise data
        xyz = [mni(idx,3)-shift(3) mni(idx,2)-shift(2) mni(idx,1)-shift(1)];
        v = value(idx);
        
        if mean(mni(idx,1))<0     
            %region on left hemisphere
            counter_left = counter_left+1;
            
            %coordinate rotation and conversion to spherical system
            degree = -50;
            xyz_r = xyz_rot(xyz,degree);
            [t,p,r] = cart2sph(xyz_r(:,1),xyz_r(:,2),xyz_r(:,3));
        	t = round(t/pi*180);
            p = round(p/pi*180);
            r = round(r);        

            %data interpolation
            [PL TL] = meshgrid([-50:49],[-90:90]);
            RL =  griddata(t,p,r,TL,PL);
            Vi =  griddata(t,p,v,TL,PL);
           
            if counter_left == 1
                VL = Vi;                
                regL = Vi;
                regL(~isnan(Vi)) = reg;                     %OVER HERE
            else
                VL(~isnan(Vi)) = Vi(~isnan(Vi));                
                regL(~isnan(Vi)) = reg;
            end        
            
        else
            %region on right hemisphere
            counter_right = counter_right+1;
            
            %coordinate rotation and conversion to spherical system
            degree = 50;
            xyz_r = xyz_rot(xyz,degree);
            [t,p,r] = cart2sph(xyz_r(:,1),xyz_r(:,2),xyz_r(:,3));
        	t = round(t/pi*180);
            p = round(p/pi*180);
            r = round(r);        

            %data interpolation
            [PR TR] = meshgrid([-49:50],[-90:90]);
            RR =  griddata(t,p,r,TR,PR);
            Vi =  griddata(t,p,v,TR,PR);
            
            if counter_right == 1
                VR = Vi;
                regR = Vi;
                regR(~isnan(Vi)) = reg;
            else
                VR(~isnan(Vi)) = Vi(~isnan(Vi));
                regR(~isnan(Vi)) = reg;
            end            
        end       

        clear degree xyz xyz_r t p r v Vi
    end
end
clear idx;     
clear reg;

[P T] = meshgrid([-100:100],[-90:90]);
R = zeros([181 201]);
V = zeros([181 201]);
region = zeros([181 201]);
if counter_left > 0
    R(:,1:100) = RL;
    V(:,1:100) = VL;
    region(:,1:100) = regL;
end
if counter_right > 0
	R(:,102:end) = RR;
    V(:,102:end) = VR;
    region(:,102:end) = regR;
end
V(isnan(V)) = 0;
R(isnan(R)) = 0;
region(isnan(region)) = 0;
clear counter_left counter_right TL TR PL PR RL RR VL VR regL regR

% %display [theta,phi] map 
% figure('color','w')
% imagesc(T(:,1),P(1,:),V); set(gca,'Ydir','normal'); xlabel('phi'); ylabel('theta');

return


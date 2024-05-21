function [xyz_r] = xyz_rot(xyz, degree)

xyz_r(:,1) =  cos(degree*pi/180)*xyz(:,1) + sin(degree*pi/180)*xyz(:,3);
xyz_r(:,2) =  xyz(:,2);
xyz_r(:,3) = -sin(degree*pi/180)*xyz(:,1) + cos(degree*pi/180)*xyz(:,3);

return


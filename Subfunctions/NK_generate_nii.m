function NK_generate_nii(handles)

% MNI position and CData --------------------------------------------------
h=waitbar(0,'Please wait ... ...');

inpath_xls=get(handles.inpath3d,'string');
[~,~,xls_data]=xlsread(inpath_xls,'Sheet1');
xls_data = xls_data(2:end,:);
xls_data=cell2mat(xls_data);

Position=xls_data(:,2:4);
CData=xls_data(:,5);

waitbar(2/10,h);

r_sph=str2num(get(handles.circle_size_3d,'string'));

Cmin=str2num(get(handles.climt_min_3d,'string'));
Cmax=str2num(get(handles.climt_max_3d,'string'));

% copy template.nii as result.nii -----------------------------------------
waitbar(3/10,h);

nii_path=get(handles.temp_nii_gii_file,'userdata');
nii_name=get(handles.temp_nii_gii_file,'string');
template_nii = fullfile(nii_path,nii_name);
save_nii=handles.save_nii_name;
copyfile(template_nii,save_nii); % copy template.nii as result.nii

waitbar(5/10,h);
% read template space and value --------------------------------------------
V = spm_vol_nifti(save_nii);
[Y,S] = spm_read_vols(V);
V.pinfo(1,1) = 1;
V.pinfo(2,1) = 0;
YN = Y;
Y(:) = 0;

Y1 = find(YN>0);
tt = S(:,Y1);

waitbar(7/10,h);

for ii = 1:size(Position,1)
    xyz = Position(ii,1:3);
    dd = pdist2(xyz,tt');
    Y(Y1(find(dd<=r_sph))) = CData(ii,1);
end

V=spm_write_vol(V,Y);

waitbar(1,h);
delete(h);
function [WS, Label] = ImageRead3D6N ( pixvalX, pixvalY, pixvalZ )

% IMAGEREAD3D - Reading & vectorizing MRI dataset.
%
% USAGE.
%    WS = ImageRead3D ( pixvalX, pixvalY, pixvalZ )
%
% DESCRIPTION.
%   Function requires readanalyze function (read references) which  
%   extract the pixel data stored in the analyze format. Path to img file
%   can be set in SPM get window. Output of readanalyze function is
%   an n-dimensional matrix with the image data. Treshold value is 100.
%   In next step function read each dimension (slice), scan it from each 
%   side searching for first value bigger than zero. X & Y coordinates are
%   saved. Z value is number of dimension. We have "skelet" of the head
%   opened in the top. We have to perfom scannin long z axis. Before that 
%   new "skelet" matrix is created and inside space of "skelet" is filled
%   with ones. Scanning along z-axis is performed, again we search
%   and store first value bigger than zero. 
%   All points on the top of the head or brain were found.
%   At the end solitary pixels are deleted, only unique pixel are stored
%   and pixels values are converted to mm according voxel size of
%   processing image.
%   Total time from beginning to the end is ~60s.
%
% INPUTS.
%   During process you have to locate your img file in SPM get window.
%   pixvalX - long of side x of one voxel in img file, default is 1 (mm)
%   pixvalY - long of side y of one voxel in img file, default is 1 (mm)
%   pixvalZ - long of side z of one voxel in img file, default is 1 (mm)
%
% OUTPUT.
%   WS is [n,3] matrix of 3D Cartesian coordinates (in millimeters)
%   which create head or brain surface. 
%
% REFERENCES.
%   readanalyze function. Authors Craig Jones & John Ashburner.
%   http://www.mri.jhmi.edu/~craig/software/
%
% See also MAKEPLOT3D.

%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 12.jan.2006,    VERSION: 1.1
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-


% CHECK INPUTS & OUTPUTS
% ..............................................................  ^..^ )~
if nargin == 0
    pixvalX = 1;    pixvalY = 1;    pixvalZ = 1; 
end

% CALL REQUIRED readanalyze FUNCTION
% ..............................................................  ^..^ )~
[F, P] = uigetfile('*.img', 'Select IMG file');
FileName = [P F];

D = readanalyze(FileName); % D is [x length x y length x z length] uint8 array.
% D = zeros(3,3,3); D(:,1,2) = 1; % for debug.
% D = ones(3,3,3); % for debug.
XLen = size(D,1);
YLen = size(D,2);
ZLen = size(D,3);

DD = double(D); DD(DD ~= 0) = 1;
XI = GetDiff(DD, 1);
YI = GetDiff(DD, 2);
ZI = GetDiff(DD, 3);
I = find(XI | YI | ZI);

Z = floor((I-1) / (XLen * YLen)) + 1;
Y = floor(mod((I-1), XLen * YLen) / XLen) + 1;
X = mod(mod((I-1), XLen * YLen), XLen) + 1;

Label = double(D(I));

WS = [X*pixvalX Y*pixvalY Z*pixvalZ];

return;


function I = GetDiff(Mat, Dim)
XLen = size(Mat,1); YLen = size(Mat,2); ZLen = size(Mat,3);

switch Dim
    case 1
        Mat1 = cat(Dim, Mat, zeros(1, YLen, ZLen));
        Mat2 = cat(Dim, zeros(1, YLen, ZLen), Mat);
        I1 = Mat1 - Mat2; I1 = I1(1:end-1,:,:);
        I2 = Mat2 - Mat1; I2 = I2(2:end,:,:);
    case 2
        Mat1 = cat(Dim, Mat, zeros(XLen, 1, ZLen));
        Mat2 = cat(Dim, zeros(XLen, 1, ZLen), Mat);
        I1 = Mat1 - Mat2; I1 = I1(:,1:end-1,:);
        I2 = Mat2 - Mat1; I2 = I2(:,2:end,:);
    case 3
        Mat1 = cat(Dim, Mat, zeros(XLen, YLen, 1));
        Mat2 = cat(Dim, zeros(XLen, YLen, 1), Mat);
        I1 = Mat1 - Mat2; I1 = I1(:,:,1:end-1);
        I2 = Mat2 - Mat1; I2 = I2(:,:,2:end);
end

I = (I1 > 0) | (I2 > 0);
return;

function map = paruly(n)
%PARULY Blueish-greenish-orangey-yellowish color map mimics, but 
% does not exactly match, the default parula color map introduced 
% in Matlab R2014b.  
% 
% Syntax and Description:
% map = paruly(n) returns an n-by-3 matrix containing a parula-like 
% colormap. If n is not specified, a value of 64 is used. 
% 
% Chad A. Greene. The University of Texas at Austin. 
% 
% See also AUTUMN, BONE, COOL, COPPER, FLAG, GRAY, HOT, HSV,
% JET, LINES, PINK, SPRING, SUMMER, WINTER, COLORMAP.

if nargin==0
    n = 64; 
end
assert(isscalar(n)==1,'paruly input must be a scalar.') 

C = load('parulynomials.mat'); 

x = linspace(0,1,n)'; 

r = polyval(C.R,x);
g = polyval(C.G,x);
b = polyval(C.B,x);

% Clamp: 
r(r<0)=0; 
g(g<0)=0; 
b(b<0)=0; 
r(r>1)=1; 
g(g>1)=1; 
b(b>1)=1; 

map = [r g b]; 


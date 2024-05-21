function [lag,criterion]=delay(x,y,shift,order,base)
%DELAY   Estimates the delay of y with respect to x using the 
%          information theoretic delay criterion
%   [LAG,CRITERION] = DELAY(X,Y) or
%   [LAG,CRITERION] = DELAY(X,Y,SHIFT) or
%   [LAG,CRITERION] = DELAY(X,Y,SHIFT,ORDER) or
%   [LAG,CRITERION] = DELAY(X,Y,SHIFT,ORDER,BASE) 
%
%   LAG         : The estimated delay of y with respect to x
%   CRITERION   : The information theoretic delay criterion
%
%   X,Y         : The time series to be analyzed, both row vectors
%   SHIFT       : The maximum relative shift; default 10
%   ORDER       : The maximum order of the algorithm; default 4
%   BASE        : The base of the logarithm; default e
%
%   See also: http://www.cs.rug.nl/~rudy/matlab/

%   R. Moddemeijer 
%   Copyright (c) by R. Moddemeijer
%   $Revision: 1.1 $  $Date: 2001/02/05 08:59:36 $

if nargin <1
   disp('Usage: [LAG,CRITERION] = DELAY(X,Y)')
   disp('       [LAG,CRITERION] = DELAY(X,Y,SHIFT)')
   disp('       [LAG,CRITERION] = DELAY(X,Y,SHIFT,ORDER)')
   disp('       [LAG,CRITERION] = DELAY(X,Y,SHIFT,ORDER,BASE)')
   return
end

% Some initial tests on the input arguments

if nargin<2
  error('Not enough arguments');
end;

if nargin>5
  error('Too many arguments');
end;

[NRowX,NColX]=size(x);
[NRowY,NColY]=size(y);

if NRowX~=1
  error('Invalid dimension of X');
end;

if NRowY~=1
  error('Invalid dimension of Y');
end;

if NColX~=NColY
  error('Unequal length of X and Y');
end;

if nargin<=2
  shift=10;
end;

if shift<0 
  error('Shift should be a positive constant')
end;

if nargin<=3
  order=3;
end;

if shift<0 
  error('Order should be a positive constant')
end;

if nargin<=3
  base=exp(1);
end;

if base<=0
  error('Base should be a positive constant')
end;

first=1+shift;
last =length(x)-shift-order+1;

% construct a large covariance matrix
% this could be done more efficiently

cov(1:2*order+2*shift,1:2*order+2*shift)=0;
for i=first:last
  xy(1:order)=x(i:i+order-1);
  xy(order+1:2*order+2*shift)=y(i-shift:i+order-1+shift);
  cov=cov+xy'*xy;
end;

% compute the criterion

for i=-shift:shift
  j=order+shift+i;
  sub(1      :order  ,1      :order  )=cov(1  :order  ,1  :order  );
  sub(order+1:2*order,order+1:2*order)=cov(j+1:j+order,j+1:j+order);
  sub(1      :order  ,order+1:2*order)=cov(1  :order  ,j+1:j+order);
  sub(order+1:2*order,1      :order  )=cov(j+1:j+order,1  :order  );
  criterion(shift+i+1)=-0.5*log(det(sub)/det(sub(1:order,1:order))/det(sub(order+1:2*order,order+1:2*order)))
end;

[dummy,lag]=max(criterion);
lag=lag-shift-1;

% base transformation

criterion=criterion/log(base);



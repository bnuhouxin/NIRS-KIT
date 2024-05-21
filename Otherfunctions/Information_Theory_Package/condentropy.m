function [estimate,nbias,sigma,descriptor]=condentropy(x,y,descriptor,approach,base)
%CONDENTROPY  Estimates the entropy of two stationary signals with
%          independent pairs of samples using various approaches.
%   [ESTIMATE,NBIAS,SIGMA,DESCRIPTOR] = CONDENTROPY(X,Y) or
%   [ESTIMATE,NBIAS,SIGMA,DESCRIPTOR] = CONDENTROPY(X,Y,DESCRIPTOR) or
%   [ESTIMATE,NBIAS,SIGMA,DESCRIPTOR] = CONDENTROPY(X,Y,DESCRIPTOR,APPROACH) or
%   [ESTIMATE,NBIAS,SIGMA,DESCRIPTOR] = CONDENTROPY(X,Y,DESCRIPTOR,APPROACH,BASE)
%
%   ESTIMATE     : The entropy estimate
%   NBIAS        : The N-bias of the estimate
%   SIGMA        : The standard error of the estimate
%   DESCRIPTOR   : The descriptor of the histogram, see also HISTOGRAM2
%
%   X,Y          : The time series to be analyzed, both row vectors
%   DESCRIPTOR   : Where DESCRIPTOR=[LOWERX,UPPERX,NCELLX;
%                                    LOWERY,UPPERY,NCELLY]
%     LOWER?     : Lowerbound of the histogram in ? direction
%     UPPER?     : Upperbound of the histogram in ? direction
%     NCELL?     : The number of cells of the histogram  in ? direction 
%   APPROACH     : The method used, one of the following ones :
%     'unbiased' : The unbiased estimate (default)
%     'mmse'     : The minimum mean square error estimate
%     'biased'   : The biased estimate
%   BASE         : The base of the logarithm; default e
%
%   See also: http://www.cs.rug.nl/~rudy/matlab/

%   R. Moddemeijer 
%   Copyright (c) by R. Moddemeijer
%   $Revision: 1.1 $  $Date: 2001/02/05 09:54:29 $



if nargin <1
   disp('Usage: [ESTIMATE,NBIAS,SIGMA,DESCRIPTOR] = CONDENTROPY(X,Y)')
   disp('       [ESTIMATE,NBIAS,SIGMA,DESCRIPTOR] = CONDENTROPY(X,Y,DESCRIPTOR)')
   disp('       [ESTIMATE,NBIAS,SIGMA,DESCRIPTOR] = CONDENTROPY(X,Y,DESCRIPTOR,APPROACH)')
   disp('       [ESTIMATE,NBIAS,SIGMA,DESCRIPTOR] = CONDENTROPY(X,Y,DESCRIPTOR,APPROACH,BASE)')
   disp('Where: DESCRIPTOR = [LOWERX,UPPERX,NCELLX;')
   disp('                     LOWERY,UPPERY,NCELLY]')
   return
end

% Some initial tests on the input arguments

[NRowX,NColX]=size(x);

if NRowX~=1
  error('Invalid dimension of X');
end;

[NRowY,NColY]=size(y);

if NRowY~=1
  error('Invalid dimension of Y');
end;

if NColX~=NColY
  error('Unequal length of X and Y');
end;

if nargin>5
  error('Too many arguments');
end;

if nargin==2
  [h,descriptor]=histogram2(x,y);
end;

if nargin>=3
  [h,descriptor]=histogram2(x,y,descriptor);
end;

if nargin<4
  approach='unbiased';
end;

if nargin<5
  base=exp(1);
end;

lowerx=descriptor(1,1);
upperx=descriptor(1,2);
ncellx=descriptor(1,3);
lowery=descriptor(2,1);
uppery=descriptor(2,2);
ncelly=descriptor(2,3);

% determine row and column sums

hy=sum(h);

estimate=0;
sigma=0;
count=0;

for nx=1:ncellx
  for ny=1:ncelly
    if h(nx,ny)~=0 
      logf=log(h(nx,ny)/hy(ny));
    else
      logf=0;
    end;
    count=count+h(nx,ny);
    estimate=estimate-h(nx,ny)*logf;
    sigma=sigma+h(nx,ny)*logf^2;
  end;
end;

% biased estimate

estimate=estimate/count;
sigma   =sqrt( (sigma/count-estimate^2)/(count-1) );
estimate=estimate+log((upperx-lowerx)/ncellx);
nbias   =-(ncellx-1)*ncelly/(2*count);

% conversion to unbiased estimate

if approach(1)=='u'
  estimate=estimate-nbias;
  nbias=0;
end;

% conversion to minimum mse estimate

if approach(1)=='m'
  estimate=estimate-nbias;
  nbias=0;
  lambda=estimate^2/(estimate^2+sigma^2);
  nbias   =(1-lambda)*estimate;
  estimate=lambda*estimate;
  sigma   =lambda*sigma;
end;

% base transformation

estimate=estimate/log(base);
nbias   =nbias   /log(base);
sigma   =sigma   /log(base);

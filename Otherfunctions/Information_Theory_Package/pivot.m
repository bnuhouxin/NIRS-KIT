function matrix=pivot(matrix,i)
%PIVOT   Computes the Gauss Jordan pivot with pivot element matrix(i,i)
%   MATRIX = PIVOT(MATRIX,I,J)
%
%   MATRIX      : The resulting matrix
%
%   MATRIX      : The input matrix
%   I           : Indication of the pivot element
%
%   See also: http://www.cs.rug.nl/~rudy/matlab/

%   R. Moddemeijer 
%   Copyright (c) by R. Moddemeijer
%   $Revision: 1.1 $  $Date: 2001/02/05 08:59:36 $

if nargin~=2
   disp('Usage: MATRIX = PIVOT(MATRIX,I)')
   return
end

% Some initial tests on the input arguments

[r,c]=size(matrix);

if r~=c
  error('Matrix is not a square matrix')
end;

if i<1 | i>r
  error('Invalid value of I');
end;

if i<1 | i>c
  error('Invalid value of J');
end;

factor=1/matrix(i,i);

for m=(1:r)
  for n=(1:c) 
    if i~=m & i~=n
      matrix(m,n)=matrix(m,n)-matrix(m,i)*matrix(i,n)*factor;
    end;
  end;
end;

for m=(1:r)
  matrix(i,m)=-matrix(i,m)*factor;
  matrix(m,i)= matrix(m,i)*factor;
end;

matrix(i,i)=factor;
      

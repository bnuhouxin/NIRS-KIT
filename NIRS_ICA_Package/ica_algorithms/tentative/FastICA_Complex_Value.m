% Complex FastICA
% Ella Bingham 1999
% Neural Networks Research Centre, Helsinki University of Technology

% This is simple Matlab code for computing FastICA on complex valued signals.
% The algorithm is reported in:
% Ella Bingham and Aapo Hyvärinen, "A fast fixed-point algorithm for 
% independent component analysis of complex valued signals", International 
% Journal of Neural Systems, Vol. 10, No. 1 (February, 2000) 1-8.

% When using the code, please refer to the abovementioned publication.

% Nonlinearity G(y) = log(eps+y) is used in this code; this corresponds to 
% G_2 in the above paper with eps=a_2.

% Some bugs corrected on Oct 2003, thanks to Ioannis Andrianakis for pointing them out

% Compatible with GPLv2 or later. http://www.gnu.org/licenses/gpl-2.0.txt

% Copyright (C) 1999  Ella Bingham
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.

clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eps = 0.1; % epsilon in G
defl = 1; % components are estimated one by one in a deflationary manner; set this to 0 if you want them all estimated simultaneously

% Generate complex signals s = r .* (cos(f) + i*sin(f)) where f is uniformly
% distributed and r is distributed according to a chosen distribution

m = 50000; %number of observations
j = 0;

% some parameters for the available distributions
bino1 = max(2, ceil(20*rand)); bino2 = rand;
exp1 = ceil(10*rand);
gam1 = ceil(10*rand); gam2 = gam1 + ceil(10*rand);
f1 = ceil(10*rand); f2 = ceil(100*rand);
poiss1 = ceil(10*rand);
nbin1 = ceil(10*rand); nbin2 = rand;
hyge1 = ceil(900*rand); hyge2 = ceil(20*rand); 
hyge3 = round(hyge1/max(2,ceil(5*rand)));
chi1 = ceil(20*rand);
beta1 = ceil(10*rand); beta2 = beta1 + ceil(10*rand);
unif1 = ceil(2*rand); unif2 = unif1 + ceil(2*rand);
gam3 = ceil(20*rand); gam4 = gam3 + ceil(20*rand);
f3 = ceil(10*rand); f4 = ceil(50*rand);
exp2 = ceil(20*rand);
rayl1 = 10;
unid1 = ceil(100*rand);
norm1 = ceil(10*rand); norm2 = ceil(10*rand);
logn1 = ceil(10*rand); logn2 = ceil(10*rand);
geo1 = rand;
weib1 = ceil(10*rand); weib2 = weib1 + ceil(10*rand);

% Choose the distributions of r
j = j + 1; r(j,:) = binornd(bino1,bino2,1,m); 
j = j + 1; r(j,:) = gamrnd(gam1,gam2,1,m); 
j = j + 1; r(j,:) = poissrnd(poiss1,1,m); 
j = j + 1; r(j,:) = hygernd(hyge1,hyge2,hyge3,1,m); 
j = j + 1; r(j,:) = betarnd(beta1,beta2,1,m); 
%j = j + 1; r(j,:) = exprnd(exp1, 1, m); 
%%j = j + 1; r(j,:) = unidrnd(unid1,1,m); 
%j = j + 1; r(j,:) = normrnd(norm1,norm2,1,m); 
%j = j + 1; r(j,:) = geornd(geo1,1,m); 

[n,m] = size(r);
for j = 1:n
	f(j,:) = unifrnd(-2*pi, 2*pi, 1, m);
end;

s = r .* (cos(f) + i*sin(f));

[n,m] = size(s);

% Whitening of s:
s = inv(diag(std(s'))) * s;

% Mixing using complex mixing matrix A: each coefficient a_{jk} is complex.
A = rand(n,n) + i*rand(n,n);
%A = orth(A);
xold = A * s;

% Whitening of x:
[Ex, Dx] = eig(cov(xold'));
Q = sqrt(inv(Dx)) * Ex';
x = Q * xold;
%x = x - mean(x,2)*ones(1,m);

% Condition in Theorem 1 should be < 0 when maximising and > 0 when 
% minimising E{G(|w^Hx|^2)}. 
for j = 1:n;
	g(j,:) = 1./(eps + abs(s(j,:)).^2) .* (1 - abs(s(j,:)).^2 .* (1./(eps + abs(s(j,:)).^2) + 1));
	Eg(j) = mean(g(j,:));
end;

% FIXED POINT ALGORITHM
if defl % Components estimated one by one
  W = zeros(n,n);
  maxcounter = 40;
  for k = 1:n
    w = rand(n,1) + i*rand(n,1);
    clear EG;
    counter = 0;
    wold = zeros(n,1);
    absAHw(:,k) = ones(n,1);
    while min(sum(abs(abs(wold) - abs(w))), maxcounter - counter) > 0.001;
      wold = w;
      g = 1./(eps + abs(w'*x).^2);
      dg = -1./(eps + abs(w'*x).^2).^2;
      w = mean(x .* (ones(n,1)*conj(w'*x)) .* (ones(n,1)*g), 2) - ...
	  mean(g + abs(w'*x).^2 .* dg) * w;
      w = w / norm(w);
      % Decorrelation:
      w = w - W*W'*w;
      w = w / norm(w);
      counter = counter + 1;
      G = log(eps + abs(w'*x).^2);
      EG(counter) = mean(G,2);
      if k < n;
	figure(3), subplot(floor(n/2),2,k), plot(EG)
	% Shows the convergence of G to a minimum or a maximum
      end;
    subplot(floor(n/2),2,1), title('Convergence of G');
    end
    QAHw(:,k) = (Q*A)'*w;
    absQAHw = abs(QAHw); %This should be one row in a permutation matrix
    % which component was found  = index
    [maximum, index] = max(absQAHw(:,k));
    % Is EG increasing or decreasing; did we find a maximum or a minimum?
    EGmuutos(k) = EG(counter) - EG(counter-1);
    if EGmuutos(k) == NaN
      break
    end;
    % isneg should always be positive (nonnegative) to fulfill Theorem 1
    isneg(k) = EGmuutos(k)*Eg(index);
    W(:,k) = w;
    counters(k) = counter;
  end; 
  absQAHW = abs((Q*A)'*W);
  maximum = max(absQAHW);
  SE = sum(absQAHW.^2) - maximum.^2 + (ones(1,n)-maximum).^2;
  SSE = sum(SE);

else %symmetric approach, all components estimated simultaneously
  C = cov(x');
  maxcounter = 10;
  counter = 0;
  W = randn(n,n) + i*randn(n,n);
  while counter < maxcounter;
    for j = 1:n
      gWx(j,:) = 1./(eps + abs(W(:,j)'*x).^2);
      dgWx(j,:) = -1./(eps + abs(W(:,j)'*x).^2).^2;
      W(:,j) = mean(x .* (ones(n,1)*conj(W(:,j)'*x)) .* (ones(n,1)*gWx(j,:)),2) - mean(gWx(j,:) + abs(W(:,j)'*x).^2 .* dgWx(j,:)) * W(:,j);
    end;
    % Symmetric decorrelation:
    %W = W * sqrtm(inv(W'*W));
    [E,D] = eig(W'*C*W);
    W = W * E * inv(sqrt(D)) * E';
    counter = counter + 1;
    GWx = log(eps + abs(W'*x).^2);
    EG(:,counter) = mean(GWx,2);
    absQAHW = abs((Q*A)'*W);
    maximum = max(absQAHW);
    % Squared error:
    SE = sum(absQAHW.^2) - maximum.^2 + (ones(1,n)-maximum).^2;
    SSE(counter) = sum(SE);
    figure(2), plot(SSE); title('SSE')
    for j = 1:n-1
    	figure(3), subplot(floor(n/2),2,j), plot(EG(j,:));
	% Shows the convergence of G to a minimum or a maximum
    end;
    subplot(floor(n/2),2,1), title('Convergence of G');
  end
  
end

shat = W'*x;

% abs((Q*A)'*W) should be a permutation matrix; Figure 1 in the IJNS paper
% measures the error in this as 
% 	absQAHW = abs((Q*A)'*W);
%	maximum = max(absQAHW);
%	SE = sum(absQAHW.^2) - maximum.^2 + (ones(1,n)-maximum).^2;

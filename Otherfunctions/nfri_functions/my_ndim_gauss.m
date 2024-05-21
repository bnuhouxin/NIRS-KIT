function pd = my_ndim_gauss(p, sd)

% Returns probabilistic density of the normal distribution with
% mean 0 and standard diviation `sd', evaluated at the values in p.
% 
% http://www.stat.wisc.edu/~mchung/teaching/MIA/reading/diffusion.gaussian.kernel.pdf.pdf

ndim = size(p, 2);  

pd = [];
for l = 1:size(p, 1);

  switch size(p, 2)
   case 1
    pd = [pd, ...
          (1 / sqrt(2 * pi) * sd) * ...
          exp(1) ^ (- (p(l) ^ 2) / (2 * sd ^ 2))];
    
   case 2
    pd = [pd, ...
          (1 / (2 * pi * sd ^ 2)) * ...
          exp(1) ^ (- (sum(p(l, :) .^ 2)) / (2 * sd ^ 2))];
    
   otherwise
    pd = [pd, ...
          (1 / (sqrt(2 * pi) * sd) ^ ndim) * ...
          exp(1) ^ (- (sum(p(l, :) .^ 2)) / (2 * sd ^ 2))];
  end
end

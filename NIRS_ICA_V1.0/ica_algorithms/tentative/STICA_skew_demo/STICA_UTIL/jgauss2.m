function op=jgauss2(ip,sd);% Convolve 2D ip array with gaussian.% sd in pixels.% Uses 2x1D convolutions.num_sds=4;mask = make_gauss_mask(sd,num_sds);% GET 2D MASK.m2=mask'*mask;op=conv2(ip,m2,'same');% REMOVE EXTRA BORDER.[R C]=size(ip);[RR CC]=size(op);b = (RR-R)/2+1+num_sds*sd;%op=remove_border(op,b);% f(1); imagesc(ip); f(2); imagesc(op);
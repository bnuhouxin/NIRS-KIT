function m=make_gauss2_mask(sd);% Make Gaussian mask for smoothing.% ip = rand(1,20);num_sds=4;N=num_sds*sd;x = linspace(-num_sds,num_sds,N);   mask = exp(-(x.*x)/(2*sd*sd));mask = mask/sum(mask);for r=-num_sds:num_sds%plot(mask); pause;R=2;C=5;ip=linspace(1,R*C,R*C);ip=reshape(ip,R,C);rr=ip(:);%op1=gauss(rr);op1=rr;cc=op1';cc=cc(:);%op2=gauss(cc);op2=cc;op2=reshape(op2,R,C);op = op2;ipop
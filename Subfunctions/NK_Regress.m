function [TF,P] = NK_Regress(y,X,Contrast,TF_Flag)

% ================ remove the subj with exclusive channel ================
 X = X(find(~isnan(y)),:);
 y = y(find(~isnan(y)));
% ================ remove the subj with exclusive channel ================


[n,ncolX]=size(X);

[b,~,r]=regress(y,X);

SSE=sum(r.^2);

if strcmpi(TF_Flag,'T')
    std_e = sqrt(SSE/(n-ncolX));
    d = sqrt(Contrast*(X'*X)^(-1)*Contrast');
    TF = (Contrast*b)./(std_e*d);
    
    DOF = n-ncolX;
    P = 2*(1-tcdf(abs(TF), DOF));
elseif strcmpi(TF_Flag,'F')
    X0 = X(:,~Contrast);
    ncolX0 = size(X0,2);
    Df_Group = sum(Contrast);
    
    b0 = (X0'*X0)^(-1)*X0'*y;
    r0 = y-X0*b0;
    SSE0 = sum(r0.^2);
    
    TF = ((SSE0-SSE)/(ncolX-ncolX0))./(SSE/(n-ncolX));
    
    Df_E = n-ncolX;
    P = (1-fcdf(TF, Df_Group, Df_E));
end

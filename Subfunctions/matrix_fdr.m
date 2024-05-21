function p_fdr=matrix_fdr(p,q)

true_mat=true(size(p,1),size(p,1));
in_true=tril(true_mat,-1);
p_vector=p(in_true);
p_fdr=FDR(p_vector,q);
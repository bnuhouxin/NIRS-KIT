function m=jappend_col(m,val);global bias_state;[r c]=size(m);if nargin==1	val = bias_state;end;m = [m,ones(r,1)*val];
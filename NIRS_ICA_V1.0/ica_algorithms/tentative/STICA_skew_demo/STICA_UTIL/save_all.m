% NBG IF FUNCTION! function save_all(fname)% global RESULTS_DIR;if exist('RESULTS_PATH','var')	old=jcd(RESULTS_PATH);	fprintf('Saving file=%s to dir= ... \n\t\t%s\n',fname,RESULTS_PATH);end;str=['save ' ''fname'' ';']eval(str);if exist('RESULTS_PATH','var')	jcd(old);end;
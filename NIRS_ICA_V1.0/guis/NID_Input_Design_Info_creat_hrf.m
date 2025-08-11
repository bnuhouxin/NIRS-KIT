function [xBF] = NID_Input_Design_Info_creat_hrf(hrftype,xBF)
dt   = xBF.dt;
% assemble basis functions
%=======================================================================

% model event-related responses
%-----------------------------------------------------------------------
if ~isfield(xBF,'name')
%	spm_input('Hemodynamic Basis functions...',1,'d')
% 	Ctype = {
% 		'hrf',...
% 		'hrf (with time derivative)',...
% 		'hrf (with time and dispersion derivatives)',...
% 		'Fourier set',...
% 		'Fourier set (Hanning)',...
% 		'Gamma functions',...
% 		'Finite Impulse Response'};
    Ctype = {
    'hrf',...
    'hrf (with time derivative)',...
    'hrf (with time and dispersion derivatives)',...
    };

	str   = 'Select basis set';
%	Sel   = spm_input(str,2,'m',Ctype);
%	xBF.name = Ctype{Sel};
% choose the type of HRF manualy
switch hrftype
    case 1
        xBF.name ='hrf'; 
    case 2
        xBF.name ='hrf (with time derivative)'; 
    case 3
        xBF.name ='hrf (with time and dispersion derivatives)'; 
end
                                                          
end

% get order and length parameters
%-----------------------------------------------------------------------
switch xBF.name

	case {	'Fourier set','Fourier set (Hanning)',...
		'Gamma functions','Finite Impulse Response'}
	%---------------------------------------------------------------
	try,	l          = xBF.length;
	catch,	l          = spm_input('window length {secs}',3,'e',32);
		xBF.length = l;
	end
	try,	h          = xBF.order;
	catch,	h          = spm_input('order',4,'e',4);
		xBF.order  = h;
	end
end



% create basis functions
%-----------------------------------------------------------------------
switch xBF.name

	case {'Fourier set','Fourier set (Hanning)'}
	%---------------------------------------------------------------
	pst   = [0:dt:l]';
	pst   = pst/max(pst);

	% hanning window
	%---------------------------------------------------------------
	if strcmp(xBF.name,'Fourier set (Hanning)')
		g  = (1 - cos(2*pi*pst))/2;
	else
		g  = ones(size(pst));
	end

	% zeroth and higher Fourier terms
	%---------------------------------------------------------------
	bf    = g;
	for i = 1:h
		bf = [bf g.*sin(i*2*pi*pst)];
		bf = [bf g.*cos(i*2*pi*pst)];	
	end

	case {'Gamma functions'}
	%---------------------------------------------------------------
	pst   = [0:dt:l]';
	bf    = spm_gamma_bf(pst,h);

	case {'Finite Impulse Response'}
	%---------------------------------------------------------------
	bin   = l/h;
	bf    = kron(eye(h),ones(round(bin/dt),1));

	case {'NONE'}
	%---------------------------------------------------------------
	bf = 1;

otherwise

	% canonical hemodynaic response function
	%---------------------------------------------------------------
	[bf p]         = NID_Input_Design_Info_creat_hrf_spm_hrf(dt);

	% add time derivative
	%---------------------------------------------------------------
	if findstr(xBF.name,'time')

		dp     = 1;
		p(6)   = p(6) + dp;
		D      = (bf(:,1) - spm_hrf(dt,p))/dp;
		bf     = [bf D(:)];
		p(6)   = p(6) - dp;

		% add dispersion derivative
		%--------------------------------------------------------
		if findstr(xBF.name,'dispersion')

			dp    = 0.01;
			p(3)  = p(3) + dp;
			D     = (bf(:,1) - spm_hrf(dt,p))/dp;
			bf    = [bf D(:)];
		end
	end

	% length and order
	%---------------------------------------------------------------
	xBF.length = size(bf,1)*dt;
	xBF.order  = size(bf,2);

end


% Orthogonalize and fill in basis function structure
%------------------------------------------------------------------------
xBF.bf  =  spm_orth(bf);
end

%=======================================================================
%- S U B - F U N C T I O N S
%=======================================================================

% compute Gamma functions functions
%-----------------------------------------------------------------------
function bf = spm_gamma_bf(u,h)
% returns basis functions used for Volterra expansion
% FORMAT bf = spm_gamma_bf(u,h);
% u   - times {seconds}
% h   - order
% bf  - basis functions (mixture of Gammas)
%_______________________________________________________________________
u     = u(:);
bf    = [];
for i = 2:(1 + h)
        m   = 2^i;
        s   = sqrt(m);
        bf  = [bf spm_Gpdf(u,(m/s)^2,m/s^2)];
end
end
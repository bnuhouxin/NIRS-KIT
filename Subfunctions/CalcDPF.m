function [DPF] = CalcDPF (A, lambda)

% Calculate age-dependent DPF (CalcDPF), Please Insert age for A and wavelength for Lambda

% ¡°General equation for the differential pathlength factor of the

% frontal human head depending on wavelength and age¡±.

% Please cite Scholkmann, & Wolf, J Biomed Opt 2013, 18, 105004 &&
%             Lia M. Hocke, et al., Algorithmsvolume 11, issue 5 (2018) for this work

% Parameters

a = 223.3;

b = 0.05624;

c = 0.8493;

d = -5.723E-7;

e = 0.001245;

f = -0.9025;

DPF = a + b.*A.^c + d.*lambda.^3 + e.*lambda.^2 + f.*lambda;

%DPF = sprintf(¡®%.2fn¡¯,DPF);
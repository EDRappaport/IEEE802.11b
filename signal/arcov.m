function [a,e] = arcov( x, p)
%ARCOV   AR parameter estimation via covariance method.
%   A = ARCOV(X,ORDER) returns the polynomial A corresponding to the AR
%   parametric signal model estimate of vector X using the Covariance method.
%   ORDER is the model order of the AR system.
%
%   [A,E] = ARCOV(...) returns the variance estimate E of the white noise
%   input to the AR model.
%
%   % Example:
%   %   Use covariance method to estimate the coefficients of an 
%   %   autoregressive process given by x(n) = 0.1*x(n-1) -0.8*x(n-2) + 
%   %   w(n).
% 
%   % Generate AR process by filtering white noise
%   a = [1, .1, -0.8];                      % AR coefficients
%   v = 0.4;                                % noise variance
%   w = sqrt(v)*randn(15000,1);             % white noise
%   x = filter(1,a,w);                      % realization of AR process
%   [ar,vr] = arcov(x,numel(a)-1)           % estimate AR model parameters 
%
%   See also PCOV, ARMCOV, ARBURG, ARYULE, LPC, PRONY.

%   Ref: S. Kay, MODERN SPECTRAL ESTIMATION,
%              Prentice-Hall, 1988, Chapter 7
%        P. Stoica and R. Moses, INTRODUCTION TO SPECTRAL ANALYSIS,
%              Prentice-Hall, 1997, Chapter 3

%   Author(s): R. Losada and P. Pacheco
%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.13.4.4 $  $Date: 2012/12/25 21:34:38 $

narginchk(2,2);

[a,e,msg,msgobj] = arparest(x,p,'covariance');
if ~isempty(msg), error(msgobj); end

% [EOF] - arcov.m

function [a,e] = armcov( x, p)
%ARMCOV   AR parameter estimation via modified covariance method.
%   A = ARMCOV(X,ORDER) returns the polynomial A corresponding to the AR
%   parametric signal model estimate of vector X using the Modified Covariance
%   method. ORDER is the model order of the AR system. 
%
%   [A,E] = ARMCOV(...) returns the variance estimate E of the white noise
%   input to the AR model.
%
%   % Example:
%   %   Use modified covariance method to estimate the coefficients of an
%   %   autoregressive process given by x(n) = 0.1*x(n-1) -0.8*x(n-2) + 
%   %   w(n).
% 
%   % Generate AR process by filtering white noise
%   a = [1, .1, -0.8];                      % AR coefficients
%   v = 0.4;                                % noise variance
%   w = sqrt(v)*randn(15000,1);             % white noise
%   x = filter(1,a,w);                      % realization of AR process
%   [ar,ec] = armcov(x,numel(a)-1)          % estimate AR model parameters 
% 
%   See also PMCOV, ARCOV, ARBURG, ARYULE, LPC, PRONY.

%   References:
%     [1] S. Lawrence Marple, DIGITAL SPECTRAL ANALYSIS WITH APPLICATIONS,
%              Prentice-Hall, 1987, Chapter 8
%     [2] Steven M. Kay, MODERN SPECTRAL ESTIMATION THEORY & APPLICATION,
%              Prentice-Hall, 1988, Chapter 7

%   Author(s): R. Losada and P. Pacheco
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.13.4.4 $  $Date: 2012/12/25 21:34:39 $

narginchk(2,2);

[a,e,msg,msgobj] = arparest(x,p,'modified');
if ~isempty(msg), error(msgobj); end

% [EOF] - armcov.m

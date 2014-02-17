function CI = confinterval(this,x,Pxx,~,CL,~)
%CONFINTERVAL  Confidence Interval for AR spectrum estimation methods.
%   CI = CONFINTERVAL(THIS,X,PXX,W,CL,FS) calculates the confidence
%   interval CI for spectrum estimate PXX based on confidence level CL. THIS is a
%   spectrum object and W is the frequency vector. X is the data used for
%   computing the spectrum estimate PXX.
% 
%   Reference : Steven M.Kay, "Modern spectral Estimation",
%   Prentice Hall, 1988, Chapter 6, pp 194-195
% 
%   Copyright 2007-2012 The MathWorks, Inc.
% 

alfa = 1-CL;
normval = norminverse(1-alfa/2,0,1);

N = length(x);
p = this.Order;

if( N/(2*p) > normval^2)
    beta = sqrt(2*p/N)* normval;
    CI = Pxx*[1-beta 1+beta];
else
    warning(message('signal:spectrum:abstractar:confinterval:InsufficientData'));
    CI = [];
end


%--------------------------------------------------------------------------
function [x] = norminverse(p,mu,sigma)
%NORMINVERSE Inverse of the normal cumulative distribution function (cdf).
%   X = NORMINVERSE(P,MU,SIGMA) returns the inverse cdf for the normal
%   distribution with mean MU and standard deviation SIGMA, evaluated at
%   the value in P.  
%
%   Default values for MU and SIGMA are 0 and 1, respectively.
%
%
%   References:
%      [1] Abramowitz, M. and Stegun, I.A. (1964) Handbook of Mathematical
%          Functions, Dover, New York, 1046pp., sections 7.1, 26.2.
%      [2] Evans, M., Hastings, N., and Peacock, B. (1993) Statistical
%          Distributions, 2nd ed., Wiley, 170pp.

if nargin<1
    error(message('signal:spectrum:abstractar:confinterval:Nargchk'));
end

if nargin < 2
    mu = 0;
end

if nargin < 3
    sigma = 1;
end

if(sigma <=0)
    error(message('signal:spectrum:abstractar:confinterval:InvalidValue', 'sigma'));
end

if(p < 0 || 1 < p)
     error(message('signal:spectrum:abstractar:confinterval:InvalidValue', 'P'));
end

x0 = -sqrt(2).*erfcinv(2*p);
x = sigma*x0 + mu;

% [EOF]


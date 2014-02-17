function [z,p,k] = ellipap(n, rp, rs)
%ELLIPAP Elliptic analog lowpass filter prototype.
%   [Z,P,K] = ELLIPAP(N,Rp,Rs) returns the zeros, poles, and gain
%   of an N-th order normalized prototype elliptic analog lowpass
%   filter with Rp decibels of ripple in the passband and a
%   stopband Rs decibels down.
%
%   % Example:
%   %   Design a 6-th order Elliptic analog low pass filter with 5 decibels 
%   %   of ripple in the passband and a stopband 90 decibels down. Display 
%   %   its frequency response.
%
%   [z,p,k]=ellipap(6,5,90);    % Lowpass filter prototype
%   [num,den]=zp2tf(z,p,k);     % Convert to transfer function form
%   freqs(num,den)              % Frequency response of analog filter 

%   Author(s): S. Orfanidis
%   Copyright 1988-2009 The MathWorks, Inc.
%   $Revision: 1.7.4.9 $  $Date: 2012/10/29 19:31:02 $

%   References:
%     [1] T. W. Parks and C. S. Burrus, Digital Filter Design,
%         John Wiley & Sons, 1987, chapter 7, section 7.3.7-8.

error(nargchk(3,3,nargin,'struct'));

validateattributes(n,{'numeric'},{'scalar','integer','positive'},'ellipap','N');
validateattributes(rp,{'numeric'},{'scalar','nonnegative'},'ellipap','Rp');
validateattributes(rs,{'numeric'},{'scalar','nonnegative'},'ellipap','Rs');

if rp == 0,
    error(message('signal:ellipap:zeroApass'));
end

if rp >= rs,
    error(message('signal:ellipap:ApassGTAstop'));
end

[z,p,H0] = ellipap2(n,rp,rs);

k = abs(H0*prod(p)/prod(z));


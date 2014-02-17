function varargout = powerest(this,x,Fs)
%POWEREST   Computes the powers and frequencies of sinusoids.
%   POW = POWEREST(H,X) returns the vector POW containing the estimates
%   of the powers of the complex sinusoids contained in the data
%   represented by X.  H must be a MUSIC object. 
%
%   X can be a vector or a matrix. If it's a vector it is a signal, if
%   it's a matrix it may be either a data matrix such that X'*X=R, or a
%   correlation matrix R.  How X is interpreted depends on the value of the
%   spectrum object's (H) InputType property.  
%
%   [POW,W] = POWEREST(...) returns in addition a vector of frequencies W
%   of the sinusoids contained in X.  W is in units of rad/sample.
%
%   [POW,F] = POWEREST(...,Fs) uses the sampling frequency Fs in the
%   computation and returns the vector of frequencies, F, in Hz.
%
%   EXAMPLES:
%      n = 0:99;   
%      s = exp(1i*pi/2*n)+2*exp(1i*pi/4*n)+exp(1i*pi/3*n)+randn(1,100);  
%      H = spectrum.music(3);
%      [P,W] = powerest(H,s);
%   
%   See also ROOTEIG, PMUSIC, PEIG, PMTM, PBURG, PWELCH and CORRMTX.

%   Author(s): P. Pacheco
%   Copyright 1988-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2010/11/08 02:33:54 $

error(nargchk(2,3,nargin,'struct'));

if nargin < 3,
    Fs = 1;
end

P = [this.NSinusoids, this.SubspaceThreshold];

if strcmpi(this.InputType,'CorrelationMatrix'),
    [w,pow] = rootmusic(x,P,'corr',Fs);
else
    [w,pow] = rootmusic(x,P,Fs);
end

varargout = {pow,w};

% [EOF]

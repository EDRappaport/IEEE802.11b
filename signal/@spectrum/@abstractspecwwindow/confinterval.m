function CI = confinterval(this,x,Pxx,W,CL,fs)
%CONFINTERVAL  Confidence Interval for Periodogram and Welch methods.
%   CI = CONFINTERVAL(THIS,X,PXX,W,CL) calculates the confidence
%   interval CI for spectrum estimate PXX based on confidence level CL. THIS is a
%   spectrum object and W is the frequency vector. X is the data used for
%   computing the spectrum estimate PXX.
%
%   Reference: D.G. Manolakis, V.K. Ingle and S.M. Kagon,
%   Statistical and Adaptive Signal Processing,
%   McGraw-Hill, 2000, Chapter 5

%   Copyright 2007-2012 The MathWorks, Inc.

name = this.EstimationMethod;
L = length(x);

switch lower(name)
    case{'periodogram'}       
        k = 1;
    case{'welch'}        
        SegLen = this.SegmentLength;
        Per = this.OverlapPercent;
        Noverlap = Per*SegLen/100;      
        k = (L-Noverlap)/(SegLen-Noverlap);              
        k = fix(k);
end

c = privatechi2conf(CL,k);
CI = Pxx*c;

% DC and Nyquist bins have only one degree of freedom for real signals
if isreal(x)
  realConf = privatechi2conf(CL,k/2);
  CI(W == 0,:) = Pxx(W == 0) * realConf;
  if isempty(fs) || ~isnumeric(fs)
    CI(W==pi,:) = Pxx(W==pi) * realConf;
  else
    CI(W==fs/2,:) = Pxx(W==fs/2) * realConf;
  end
end
% [EOF]

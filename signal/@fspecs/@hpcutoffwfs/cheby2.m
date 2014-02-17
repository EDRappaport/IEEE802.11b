function Hd = cheby2(this, varargin)
%CHEBY2 Chebyshev Type II digital filter design.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/09/20 22:35:44 $

N = this.FilterOrder;

nfreq = get(this, 'NormalizedFrequency');
normalizefreq(this, true);

Fc = this.F3db;
Fst = this.Fstop;

normalizefreq(this, nfreq);

[isvalid, errmsg, errid] = checkincfreqs(this,{'Fstop','F3dB'});
if ~isvalid
    error(message(errid,errmsg));
end

% Compute analog frequency
Wc = 1/tan(pi*Fc/2);

% Determine analog stopband edge frequency
Wst = 1/tan(pi*Fst/2);

% Find estop, Astop
est = cosh(N*acosh(Wst/Wc));
Ast = 10*log10(est^2+1);

% Convert to highpass with stopband-edge specifications
hs = fspecs.hpstop(N,Fst,Ast);

Hd = cheby2(hs,varargin{:});

% [EOF]

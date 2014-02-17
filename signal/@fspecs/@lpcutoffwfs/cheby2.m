function Hd = cheby2(this, varargin)
%CHEBY2 Chebyshev Type II digital filter design.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/09/20 22:35:47 $

N = this.FilterOrder;

nfreq = get(this, 'NormalizedFrequency');
normalizefreq(this, true);

Fc  = this.F3dB;
Fst = this.Fstop;

normalizefreq(this, nfreq);

[isvalid, errmsg, errid] = checkincfreqs(this,{'F3dB','Fstop'});
if ~isvalid
    error(message(errid,errmsg));
end

% Compute analog frequency
Wc = tan(pi*Fc/2);

% Determine analog stopband edge frequency
Wst = tan(pi*Fst/2);

% Find estop, Astop
est = cosh(N*acosh(Wst/Wc));
Ast = 10*log10(est^2+1);

% Construct a new fdesign object with the converted specs
hs = fspecs.lpstop(N, Fst, Ast);

Hd = cheby2(hs,varargin{:});


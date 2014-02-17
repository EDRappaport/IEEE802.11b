function Hd = cheby1(this, varargin)
%CHEBY1 Chebyshev Type I digital filter design.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/09/20 22:35:46 $

N  = this.FilterOrder;

nfreq = get(this, 'NormalizedFrequency');
normalizefreq(this, true);

Fc = this.F3dB;
Fp = this.Fpass;

normalizefreq(this, nfreq);

[isvalid, errmsg, errid] = checkincfreqs(this,{'Fpass','F3dB'});
if ~isvalid
    error(message(errid,errmsg));
end

% Compute analog frequency
Wc = tan(pi*Fc/2);

% Determine analog passband edge frequency
Wp = tan(pi*Fp/2);

% Find epass, Apass
ep = 1/cosh(N*acosh(Wc/Wp));
Ap = 10*log10(ep^2+1);

% Convert to lowpass with passband-edge specifications
hs = fspecs.lppass(N,Fp,Ap);

Hd = cheby1(hs,varargin{:});


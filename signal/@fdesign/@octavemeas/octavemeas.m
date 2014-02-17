function this = octavemeas(hfilter, hfdesign, varargin)
%OCTAVEMEAS   Construct an OCTAVEMEAS object.

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2007/12/14 15:11:32 $

error(nargchk(1,inf,nargin,'struct'));

this = fdesign.octavemeas;

% Parse the inputs to get the specification and the measurements list.
minfo = parseconstructorinputs(this, hfilter, hfdesign, varargin{:});

if this.NormalizedFrequency, Fs = 2;
else,                        Fs = this.Fs; end

% Measure the arbitrary magnitude filter.
F = minfo.Frequencies;
this.Frequencies = F;
A = 20*log10(abs(freqz(hfilter,F,Fs)));
this.Magnitudes = A(:).';

% [EOF]

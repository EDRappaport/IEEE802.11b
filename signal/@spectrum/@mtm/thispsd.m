function [Pxx,W] = thispsd(this,x,opts)
%THISPSD   Power spectral density (PSD) via MTM.
%
% OPTS = {NFFT, Fs(?), and SpectrumType}.
%
% This is a private method.

%   Author(s): P. Pacheco
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.9 $Date: 2011/05/13 18:13:49 $

error(nargchk(2,3,nargin,'struct'));

% Convert CombineMethod enum type to strings accepted by the function.
combineMethod = getcombinemethodstr(this);
opts = {opts{:},combineMethod};

if strcmpi(this.SpecifyDataWindowAs,'TimeBW'),
    [Pxx W] = pmtm(x,this.TimeBW,opts{:});
else
    validatesizes(this,x); % Validate the size of E and V
    [Pxx W] = pmtm(x,this.DPSS,this.Concentrations,opts{:});
end

%--------------------------------------------------------------------------
function validatesizes(this,x)
% Return error if size mismatch is found.

if size(this.DPSS,2) ~= length(this.Concentrations),
     error(message('signal:spectrum:mtm:thispsd:invalidNumCols', 'Concentration'));
end

if size(this.DPSS,1) ~= length(x),
     error(message('signal:spectrum:mtm:thispsd:invalidNumRows'));
end

% [EOF]

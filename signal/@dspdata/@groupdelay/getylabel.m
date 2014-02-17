function ylbl = getylabel(this)
%GETYLABEL   Get the ylabel.

%   Author(s): J. Schickler
%   Copyright 2004 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/10/31 06:33:45 $

if this.NormalizedFrequency
    ylbl = getString(message('signal:dspdata:dspdata:GroupDelayinSamples'));
else
    ylbl = getString(message('signal:dspdata:dspdata:GroupDelayinSeconds'));
end

% [EOF]

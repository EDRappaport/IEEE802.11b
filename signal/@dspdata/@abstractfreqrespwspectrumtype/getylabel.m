function ylbl = getylabel(this)
%GETYLABEL Get the ylabel.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/10/31 06:33:39 $

if this.NormalizedFrequency
    ylbl = getString(message('signal:dspdata:dspdata:PowerfrequencydBradsample'));
else
    ylbl = getString(message('signal:dspdata:dspdata:PowerfrequencydBHz'));
end


% [EOF]

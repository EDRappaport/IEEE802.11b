function ylbl = getylabel(this)
%GETYLABEL Get the ylabel.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/10/31 06:33:36 $

if this.plotindb             
    ylbl = getString(message('signal:dspdata:dspdata:MagnitudedB'));
else
    ylbl = getString(message('signal:dspdata:dspdata:Magnitude'));
end


% [EOF]

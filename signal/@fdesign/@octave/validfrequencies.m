function f = validfrequencies(this)
%VALIDFREQUENCIES  Return the valid values for the 'CenterFreq' property.

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:24:53 $

f = getvalidcenterfrequencies(this.Currentspecs);
if this.NormalizedFrequency,
    f = f/24000;
end

% [EOF]

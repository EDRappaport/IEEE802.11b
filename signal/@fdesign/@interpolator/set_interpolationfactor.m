function interpolationfactor = set_interpolationfactor(this, interpolationfactor)
%SET_INTERPOLATIONFACTOR   PreSet function for the 'interpolationfactor' property.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:24:42 $

set(this, 'privInterpolationFactor', interpolationfactor);

updatecurrentfdesign(this);

% [EOF]

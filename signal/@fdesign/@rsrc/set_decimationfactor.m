function decimationfactor = set_decimationfactor(this, decimationfactor)
%SET_DECIMATIONFACTOR  PreSet function for the 'decimationfactor' property.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:25:28 $

set(this, 'privDecimationFactor', decimationfactor);

updatecurrentfdesign(this);

% [EOF]

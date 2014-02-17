function decimationfactor = set_decimationfactor(this, decimationfactor)
%SET_DECIMATIONFACTOR  PreSet function for the 'decimationfactor' property.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/11/17 22:44:23 $

set(this, 'privDecimationFactor', decimationfactor);

if isprop(this.CurrentSpecs, 'privDecimationFactor')
    set(this.CurrentSpecs, 'privDecimationFactor', decimationfactor);
end

% [EOF]

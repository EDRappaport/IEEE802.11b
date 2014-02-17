function interpolationfactor = set_interpolationfactor(this, interpolationfactor)
%SET_INTERPOLATIONFACTOR   PreSet function for the 'interpolationfactor' property.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/11/17 22:44:24 $

set(this, 'privInterpolationFactor', interpolationfactor);

if isprop(this.CurrentSpecs, 'privInterpolationFactor')
    set(this.CurrentSpecs, 'privInterpolationFactor', interpolationfactor);
end

% [EOF]

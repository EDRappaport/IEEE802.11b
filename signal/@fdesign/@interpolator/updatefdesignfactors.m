function updatefdesignfactors(this)
%UPDATEFDESIGNFACTORS   Update the current FDesign rate change factors.

%   Author(s): J. Schickler
%   Copyright 2005-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2009/02/13 15:13:50 $

interpolationfactor = get(this, 'InterpolationFactor');

if isprop(this.CurrentFDesign, 'InterpolationFactor')
    set(this.CurrentFDesign, 'InterpolationFactor', interpolationfactor);
end

% [EOF]

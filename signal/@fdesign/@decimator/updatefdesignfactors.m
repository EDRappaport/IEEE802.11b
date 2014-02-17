function updatefdesignfactors(this)
%UPDATEFDESIGNFACTORS   Update the CurrentFDesign ratechange factors.

%   Author(s): J. Schickler
%   Copyright 2005-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2009/02/13 15:13:46 $

decimationfactor = get(this, 'DecimationFactor');

if isprop(this.CurrentFDesign, 'DecimationFactor')
    set(this.CurrentFDesign, 'DecimationFactor', decimationfactor);
end

% [EOF]

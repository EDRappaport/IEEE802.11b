function updatefdesignfactors(this)
%UPDATEFDESIGNFACTORS   Update the CurrentFDesign rate change factors.

%   Author(s): J. Schickler
%   Copyright 2005-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2009/02/13 15:13:57 $

interpfactor = get(this, 'InterpolationFactor');
decimfactor  = get(this, 'DecimationFactor');

if isprop(this.CurrentFDesign, 'DecimationFactor')
    set(this.CurrentFDesign, 'DecimationFactor', decimfactor);
end
if isprop(this.CurrentFDesign, 'InterpolationFactor')
    set(this.CurrentFDesign, 'InterpolationFactor', interpfactor);
end

% [EOF]

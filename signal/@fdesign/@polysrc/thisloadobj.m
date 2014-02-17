function thisloadobj(this, s)
%THISLOADOBJ   Load this object.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/11/17 22:44:26 $

set(this, 'InterpolationFactor', s.InterpolationFactor);
set(this, 'DecimationFactor', s.DecimationFactor);

% [EOF]

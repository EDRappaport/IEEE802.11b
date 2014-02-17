function s = thissaveobj(this)
%THISSAVEOBJ Save this object.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/11/17 22:44:27 $

s.InterpolationFactor = get(this, 'InterpolationFactor');
s.DecimationFactor = get(this, 'DecimationFactor');

% [EOF]

function setratechangefactors(this, ratechangefactors)
%SETRATECHANGEFACTORS   Set the ratechangefactors.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/11/17 22:44:25 $

set(this, 'InterpolationFactor', ratechangefactors(1), ...
    'DecimationFactor', ratechangefactors(2));

% [EOF]

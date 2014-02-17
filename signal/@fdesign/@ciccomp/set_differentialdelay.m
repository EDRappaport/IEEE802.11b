function M = set_differentialdelay(this, M)
%SET_DIFFERENTIALDELAY   PreSet function for the 'differentialdelay' property.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/04/04 16:59:30 $

set(this.CurrentSpecs, 'FrequencyFactor', M/2);

% [EOF]

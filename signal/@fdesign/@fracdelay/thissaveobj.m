function s = thissaveobj(this)
%THISSAVEOBJ   Save this object.

%   Author(s): J. Schickler
%   Copyright 1999-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2006/06/27 23:35:59 $

s.FracDelay = get(this, 'FracDelay');

% [EOF]

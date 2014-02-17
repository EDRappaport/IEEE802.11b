function multiratedefaults(this, maxfactor)
%MULTIRATEDEFAULTS   

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2005/12/22 19:01:02 $

set(this, 'Band', maxfactor);
defaulttw(this, maxfactor);

% [EOF]

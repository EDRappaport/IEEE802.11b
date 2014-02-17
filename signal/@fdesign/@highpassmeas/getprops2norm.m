function props2norm = getprops2norm(this)
%GETPROPS2NORM   Get the props2norm.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:24:15 $

% Return the frequency values.
props2norm = get(this, {...
    'Fstop' ...
    'F6dB' ...
    'F3dB' ...
    'Fpass'});

% [EOF]

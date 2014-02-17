function s = thissaveobj(this)
%THISSAVEOBJ   Save this object.

%   Author(s): J. Schickler
%   Copyright 1999-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:24:52 $

s.BandsPerOctave = get(this, 'BandsPerOctave');
s.Mask = get(this, 'Mask');

% [EOF]

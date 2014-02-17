function minfo = measureinfo(this)
%MEASUREINFO Return a structure of information for the measurements.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/02/21 07:09:13 $

[F, A] = getmask(this);
minfo.Frequencies = F;
minfo.Amplitudes = A;

% [EOF]

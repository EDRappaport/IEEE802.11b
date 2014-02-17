function ratechangefactors = getratechangefactors(this)
%GETRATECHANGEFACTORS   Get the ratechangefactors.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:24:36 $

ratechangefactors = [get(this, 'InterpolationFactor') 1];

% [EOF]

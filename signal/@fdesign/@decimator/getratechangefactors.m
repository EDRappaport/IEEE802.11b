function ratechangefactors = getratechangefactors(this)
%GETRATECHANGEFACTORS   Get the ratechangefactors.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:23:43 $

ratechangefactors = [1 get(this, 'DecimationFactor')];

% [EOF]

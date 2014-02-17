function defaulttw(this,band)
%DEFAULTTW   

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/12/22 19:01:01 $

if band>5,
    set(this, 'TransitionWidth', .5/band);
end


% [EOF]

function b = thisisreal(this)
%THISISREAL   True if the object is real.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:32 $

b = isreal(this.Coefficients);

% [EOF]

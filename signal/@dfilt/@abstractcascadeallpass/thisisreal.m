function b = thisisreal(this)
%THISISREAL   True if the object is real.

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:23:25 $

Hd = dispatch(this);

b = isreal(Hd);

% [EOF]

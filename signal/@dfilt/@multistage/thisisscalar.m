function b = thisisscalar(this)
%THISISSCALAR   Returns true if all the sections are scalar.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2004/12/26 22:08:56 $

b = all(isscalar(this.Stage));

% [EOF]

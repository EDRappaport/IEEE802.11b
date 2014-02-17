function rcvals = refvals(this)
%REFVALS   Return the reference values.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2004/03/15 22:26:33 $

rcnames = refcoefficientnames(this);

rcvals = get(this,rcnames);

% [EOF]

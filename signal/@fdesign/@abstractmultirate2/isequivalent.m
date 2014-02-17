function b = isequivalent(this, htest)
%ISEQUIVALENT   True if the object is equivalent.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/08/20 13:25:59 $

if isa(htest, class(this)) && ...
        strcmpi(this.Response, htest.Response) && ...
        isequal(this.getratechangefactors, htest.getratechangefactors),
    b = isequivalent(this.CurrentFDesign, htest.CurrentFDesign);
else
    b = false;
end

% [EOF]

function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:25:10 $


if strcmpi(this.Response,'nyquist'),
    defaultmethod = 'kaiserwin';
else
    defaultmethod = 'equiripple';
end

% [EOF]

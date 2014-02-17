function hfmethod = getfmethod(this, methodname)
%GETFMETHOD   Get the fmethod.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:12:26 $

% If we are passed a string, we assume that it is the name of the design
% method instead of the design method object.
if ischar(methodname) && isdesignmethod(this, methodname)
    hfmethod = feval(getdesignobj(this.CurrentSpecs, methodname));
elseif ~isa(methodname, 'fmethod.abstractdesign')
    error(message('signal:fdesign:abstracttypewspecs:getfmethod:InvalidMethod', methodname));
else
    hfmethod = methodname;
end

% [EOF]

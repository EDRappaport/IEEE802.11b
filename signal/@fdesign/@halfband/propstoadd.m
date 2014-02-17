function p = propstoadd(this)
%PROPSTOADD   Return the properties to add to the parent object.

%   Copyright 2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/10/23 18:47:55 $

p = propstoadd(this.CurrentSpecs);

p = {'Description','Type', p{:}};

% [EOF]

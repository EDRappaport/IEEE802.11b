function validatedata(this, data)
%VALIDATEDATA   Validate the data for this object.

%   Author(s): P. Pacheco
%   Copyright 1988-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:11:41 $

% Call "private" function (using a trick) which is also used by abstractps.
dspdata.validatedata(this,data);

% [EOF]

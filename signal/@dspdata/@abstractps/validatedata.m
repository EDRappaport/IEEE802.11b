function validatedata(this, data)
%VALIDATEDATA   Validate the data for this object.

%   Author(s): J. Schickler
%   Copyright 1988-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2011/05/13 18:11:32 $

% Call "private" function (using a trick) which is also used by pseudospectrum.
dspdata.validatedata(this,data); 



% [EOF]

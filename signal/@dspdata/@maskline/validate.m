function b = validate(this)
%VALIDATE   Validate the object.

%   Author(s): J. Schickler
%   Copyright 2004 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:11:36 $

b   = true;

if length(this.FrequencyVector) ~= length(this.MagnitudeVector)
    error(message('signal:dspdata:maskline:validate:invalidateState', 'FrequencyVector', 'Magnitude'));
end


% [EOF]

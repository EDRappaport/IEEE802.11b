function amplitudes = set_amplitudes(this, amplitudes)
%SET_AMPLITUDES   PreSet function for the 'amplitudes' property.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:10:49 $

if ~any(isreal(amplitudes)),
        error(message('signal:fspecs:abstractsbarbmag:set_amplitudes:InvalidAmplitudes'))
end

% [EOF]

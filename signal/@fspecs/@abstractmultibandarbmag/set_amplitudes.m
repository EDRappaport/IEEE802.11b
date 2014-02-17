function amplitudes = set_amplitudes(~, amplitudes)
%SET_AMPLITUDES PreSet function for the 'amplitudes' property.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/02/21 07:09:06 $

if ~any(isreal(amplitudes)),
  error(message('signal:fspecs:abstractmultibandarbmag:set_amplitudes:InvalidAmplitudes'))
end

% Force row vector
amplitudes = amplitudes(:).';

% [EOF]

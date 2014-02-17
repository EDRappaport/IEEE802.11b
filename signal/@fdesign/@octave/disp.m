function disp(this)
%DISP   Display this object.

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:24:39 $

s = get(this);
s = reorderstructure(s, 'Response', 'BandsPerOctave', 'Mask', 'Specification', 'Description');

if s.NormalizedFrequency
    s = rmfield(s, 'Fs');
end

siguddutils('dispstr', s);

% [EOF]

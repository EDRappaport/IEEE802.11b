function disp(this)
%DISP   Display this object.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/10/16 06:41:21 $

s = get(this);
s = reorderstructure(s, 'Response', 'Specification', 'Description', 'NormalizedFrequency','Fs');

if s.NormalizedFrequency
    s = rmfield(s, 'Fs');    
end
siguddutils('dispstr', s);

% [EOF]

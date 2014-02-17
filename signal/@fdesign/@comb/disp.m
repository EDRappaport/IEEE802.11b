function disp(this)
%DISP   Display the design object.

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/10/31 07:00:38 $

s = get(this);
s = reorderstructure(s, 'Response', 'CombType', 'Specification', ...
    'Description', 'NormalizedFrequency');

if s.NormalizedFrequency
    s = rmfield(s, 'Fs');
end

if isequal(lower(this.CombType),'notch')
    s = rmfield(s,'PeakFrequencies');
else
    s = rmfield(s,'NotchFrequencies');
end

siguddutils('dispstr', s);

% [EOF]

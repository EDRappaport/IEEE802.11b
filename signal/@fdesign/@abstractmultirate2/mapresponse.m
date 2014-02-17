function R = mapresponse(~, SR)
%MAPRESPONSE   

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/04/07 09:13:22 $

switch lower(SR)
    case 'ciccomp'
        R = 'CIC Compensator';
    case 'arbmag'
        R = 'Arbitrary Magnitude';
    case 'arbmagnphase'
        R = 'Arbitrary Magnitude and Phase';
    case 'isinclp'
        R = 'Inverse-sinc Lowpass';
    case 'isinchp'
        R = 'Inverse-sinc Highpass';        
    case 'rcosine'
        R = 'Raised Cosine';
    case 'sqrtrcosine'
        R = 'Square Root Raised Cosine';
    otherwise
        R = [upper(SR(1)) SR(2:end)];
end

% [EOF]

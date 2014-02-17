function realizeflag = isrealizable(Hd)
%ISREALIZABLE True if the structure can be realized by simulink

%   Author(s): Honglei Chen
%   Copyright 1988-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/12/06 00:04:30 $

realizeflag = true;
% Limited support for AllpassCoefficients
% 
c = coeffs(Hd);                                                       
if isempty(find(length(c.AllpassCoefficients)==[0 1 2 4], 1)),                    
    warning(message('signal:dfilt:allpass:isrealizable:InvalidCoeffs')); 
    realizeflag = false;
end                    
% [EOF]

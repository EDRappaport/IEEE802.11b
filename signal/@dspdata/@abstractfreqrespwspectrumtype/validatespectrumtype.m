function validatespectrumtype(this,spectrumType)
%VALIDATESPECTRUMTYPE   Validate SpectrumType property value.
%
% This error checking should be done in the object's set method, but for
% enum datatypes UDD first checks the list before calling the set method.

%   Author(s): P. Pacheco
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:11:30 $

validStrs = {'onesided','twosided'};
if ~ischar(spectrumType) | ~any(strcmpi(spectrumType,validStrs)),
    error(message('signal:dspdata:abstractfreqrespwspectrumtype:validatespectrumtype:invalidSpectrumType', 'SpectrumType', validStrs{ 1 }, validStrs{ 2 }));
end


% [EOF]

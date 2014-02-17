function measureconstructor = getmeasureconstructor(this)
%GETMEASURECONSTRUCTOR   Get the measureconstructor.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2007/10/23 18:47:53 $

if strcmpi(this.Type,'Lowpass'),
    measureconstructor = 'fdesign.lowpassmeas';
elseif strcmpi(this.Type,'Highpass'),
    measureconstructor = 'fdesign.highpassmeas';
end

% [EOF]

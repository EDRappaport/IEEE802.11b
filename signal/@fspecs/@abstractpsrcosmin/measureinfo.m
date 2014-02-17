function minfo = measureinfo(this)
%MEASUREINFO   Return a structure of information for the measurements.

%   Copyright 2008-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/11/17 21:22:45 $

minfo.Fpass = (1-this.RolloffFactor)/this.SamplesPerSymbol;
minfo.Fstop = (1+this.RolloffFactor)/this.SamplesPerSymbol;
minfo.Apass = [];
minfo.Astop = [];

if ~this.NormalizedFrequency
  minfo.Fpass = minfo.Fpass*this.Fs/2;
  minfo.Fstop = minfo.Fstop*this.Fs/2;
end

% [EOF]

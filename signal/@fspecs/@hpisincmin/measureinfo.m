function minfo = measureinfo(this)
%MEASUREINFO Return a structure of information for the measurements.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:30 $

minfo.Fpass = this.Fpass;
minfo.Fcutoff = [];
minfo.Fstop = this.Fstop;
minfo.Apass = this.Apass;
minfo.Astop = this.Astop;

minfo.FrequencyFactor = this.FrequencyFactor;
minfo.Power           = this.Power;

% [EOF]

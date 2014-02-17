function minfo = measureinfo(this)
%MEASUREINFO Return a structure of information for the measurements.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:16 $

minfo.Fpass = this.Fpass;
minfo.Fcutoff = [];
minfo.Fstop = this.Fstop;
minfo.Apass = [];
minfo.Astop = [];

minfo.FrequencyFactor = this.FrequencyFactor;
minfo.Power           = this.Power;

% [EOF]

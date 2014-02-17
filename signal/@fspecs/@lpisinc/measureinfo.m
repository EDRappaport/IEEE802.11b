function minfo = measureinfo(this)
%MEASUREINFO Return a structure of information for the measurements.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/06/06 17:17:52 $

minfo.Fpass = this.Fpass;
minfo.Fcutoff = [];
minfo.Fstop = this.Fstop;
minfo.Apass = [];
minfo.Astop = [];

minfo.FrequencyFactor     = this.FrequencyFactor;
minfo.Power               = this.Power;
minfo.CICRateChangeFactor = this.CICRateChangeFactor;


% [EOF]

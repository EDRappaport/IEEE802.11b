function specs = thisgetspecs(this)
%THISGETSPECS Get the specs.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:47 $

specs.Fpass           = this.Fstop;
specs.Fstop           = this.Fstop;
specs.Apass           = this.Apass;
specs.Astop           = this.Astop;
specs.FrequencyFactor = this.FrequencyFactor;
specs.Power           = this.Power;

% [EOF]

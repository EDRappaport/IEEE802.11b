function specs = thisgetspecs(this)
%THISGETSPECS Get the specs.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/06/06 17:18:01 $

specs.Fpass               = this.Fstop;
specs.Fstop               = this.Fstop;
specs.Apass               = this.Apass;
specs.Astop               = this.Astop;
specs.FrequencyFactor     = this.FrequencyFactor;
specs.Power               = this.Power;
specs.CICRateChangeFactor = this.CICRateChangeFactor;


% [EOF]

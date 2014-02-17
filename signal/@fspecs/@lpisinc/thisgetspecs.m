function specs = thisgetspecs(this)
%THISGETSPECS   Get the specs.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/06/06 17:17:53 $

specs.Fpass               = this.Fpass;
specs.Fstop               = this.Fstop;
specs.Apass               = NaN;
specs.Astop               = NaN;
specs.FrequencyFactor     = this.FrequencyFactor;
specs.Power               = this.Power;
specs.CICRateChangeFactor = this.CICRateChangeFactor;


% [EOF]

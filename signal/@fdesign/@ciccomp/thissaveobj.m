function s = thissaveobj(this)
%THISSAVEOBJ Save this object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/06/06 17:17:49 $

s.DifferentialDelay   = this.DifferentialDelay;
s.NumberOfSections    = this.NumberOfSections;
s.CICRateChangeFactor = this.CICRateChangeFactor; % Property added in R2011b

% [EOF]
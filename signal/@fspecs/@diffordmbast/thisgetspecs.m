function specs = thisgetspecs(this)
%THISGETSPECS Get the specs.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:09 $

specs.Fpass = this.Fpass;
specs.Fstop = this.Fstop;
specs.Apass = nan;
specs.Astop = this.Astop;

% [EOF]

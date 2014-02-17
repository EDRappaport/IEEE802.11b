function specs = thisgetspecs(this)
%THISGETSPECS Get the specs  - used in FVTOOL for drawing the mask.

%   Copyright 2008-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:23 $

specs.Fpass = this.F3dB;
specs.Fstop = this.F3dB;
specs.Apass = NaN;
specs.Astop = NaN;

% [EOF]

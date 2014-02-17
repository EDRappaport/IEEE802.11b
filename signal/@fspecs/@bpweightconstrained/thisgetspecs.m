function specs = thisgetspecs(this)
%THISGETSPECS   

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:37 $

specs.Fstop1 = this.Fstop1;
specs.Fpass1 = this.Fpass1;
specs.Fpass2 = this.Fpass2;
specs.Fstop2 = this.Fstop2;
if this.Stopband1Constrained
  specs.Astop1 = this.Astop1;
else
  specs.Astop1 = NaN;
end
if this.PassbandConstrained
    specs.Apass  = this.Apass;
else
  specs.Apass  = NaN;
end
if this.Stopband2Constrained
  specs.Astop2 = this.Astop2;
else
  specs.Astop2 = NaN;
end

% [EOF]

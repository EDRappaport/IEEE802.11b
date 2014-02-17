function multiratedefaults(this, maxfactor)
%MULTIRATEDEFAULTS Setup the isinchp object for multirate.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/04/07 09:13:29 $

if maxfactor == 1
  fs = 0.45;
  fp = 0.55;
else
  fs = 1 -  1/maxfactor;
  fp = 1 - .8/maxfactor;
end

% Scale by the sampling frequency.
if ~this.NormalizedFrequency
    fp = fp*this.Fs/2;
    fs = fs*this.Fs/2;
end

set(this, 'Fstop', fs, 'Fpass', fp);

% [EOF]

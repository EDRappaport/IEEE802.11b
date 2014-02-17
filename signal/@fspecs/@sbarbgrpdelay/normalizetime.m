function normalizetime(this,oldFs,oldNormFreq)
%NORMALIZETIME Normalize time specifications.

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/12/27 01:21:14 $

newnormfreq = this.NormalizedFrequency;
newFs = this.Fs;

if newnormfreq && ~oldNormFreq,
    this.GroupDelay = this.GroupDelay*oldFs;
elseif ~newnormfreq && oldNormFreq,
    this.GroupDelay = this.GroupDelay/newFs;
elseif ~newnormfreq && ~oldNormFreq, 
    this.GroupDelay = this.GroupDelay*oldFs/newFs;
end
            
% [EOF]

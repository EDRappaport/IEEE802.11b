function normalizefreq(this,varargin)
%NORMALIZEFREQ  Normalize frequency specifications. 

%   Author(s): R. Losada
%   Copyright 2003-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2006/06/27 23:35:54 $

oldnormfreq = this.NormalizedFrequency;
oldFs = this.Fs;

normalizefreq(this.CurrentSpecs,varargin{:});

newnormfreq = this.NormalizedFrequency;
newFs = this.Fs;

if newnormfreq && ~oldnormfreq,
    this.FracDelay = this.FracDelay*oldFs;
elseif ~newnormfreq && oldnormfreq,
    this.FracDelay = this.FracDelay/newFs;
elseif ~newnormfreq && ~oldnormfreq, 
    this.FracDelay = this.FracDelay*oldFs/newFs;
end
        
    
% [EOF]

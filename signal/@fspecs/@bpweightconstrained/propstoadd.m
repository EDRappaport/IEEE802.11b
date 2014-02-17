function p = propstoadd(this)
%PROPSTOADD Return the properties to add to the parent object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:34 $

p = {'NormalizedFrequency', 'Fs','FilterOrder','Fstop1',...
  'Fpass1','Fpass2','Fstop2','Stopband1Constrained',...
  'PassbandConstrained','Stopband2Constrained'};

if this.Stopband1Constrained
  p{end+1} = 'Astop1';
end
if this.PassbandConstrained
  p{end+1} = 'Apass';
end
if this.Stopband2Constrained
  p{end+1} = 'Astop2';
end

% [EOF]

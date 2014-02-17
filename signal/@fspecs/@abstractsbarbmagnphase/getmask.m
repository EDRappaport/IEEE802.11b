function [F, A] = getmask(this)
%GETMASK Get the mask.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/02/21 07:09:15 $

F = this.Frequencies;
A = this.FreqResponse;

if ~this.NormalizedFrequency
  F = F/(this.Fs/2);
end

% [EOF]

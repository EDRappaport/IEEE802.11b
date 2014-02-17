function [F, A] = getmask(this)
%GETMASK Get the mask.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/02/21 07:09:12 $

F = this.Frequencies;
A = this.Amplitudes;

if ~this.NormalizedFrequency
  F = F/(this.Fs/2);
end
% [EOF]

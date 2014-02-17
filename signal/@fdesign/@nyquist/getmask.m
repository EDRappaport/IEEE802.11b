function [F, A] = getmask(this, fcns, rcf, specs)
%GETMASK   Get the mask.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2005/06/30 17:34:38 $

% If the specs were not passed in or are [], use the design specifications.
if nargin < 4 || isempty(specs)
    specs = getspecs(this.CurrentSpecs);
end

fpass = specs.Fpass;
fstop = specs.Fstop;

% The frequency vector is always the same.
F = [1 fpass fpass 0 0 fstop fstop 1]*fcns.getfs()/2;

A = fcns.gethighlow(specs);

% [EOF]

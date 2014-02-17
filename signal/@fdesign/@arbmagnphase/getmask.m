function [F, A, P] = getmask(this, fcns, ~, ~)
%GETMASK Get the mask.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/02/21 07:08:58 $

w = warning('off'); %#ok<WNOFF>
[F, A] = getmask(this.CurrentSpecs);
P = fcns.getarbphase(angle(A));
A = fcns.getarbmag(abs(A)); % Convert units
F = F*(fcns.getfs()/2); 
warning(w);

% [EOF]

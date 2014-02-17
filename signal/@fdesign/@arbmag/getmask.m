function [F, A] = getmask(this, fcns, ~, ~)
%GETMASK Get the mask.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/02/21 07:08:53 $

w = warning('off'); %#ok<WNOFF>
[F, A] = getmask(this.CurrentSpecs);
A = fcns.getarbmag(A);
F = F*(fcns.getfs()/2); 
warning(w);

% [EOF]

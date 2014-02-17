function f = thisislinphase(Hd,tol)
%THISISLINPHASE  True for linear phase filter.
%   THISISLINPHASE(Hd) returns 1 if filter Hd is linear phase, and 0 otherwise.
%
%   THISISLINPHASE(Hd,TOL) uses tolerance TOL to determine when two numbers are
%   close enough to be considered equal.
%
%   See also DFILT.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/09/20 22:34:50 $

% This should be private

if nargin<2
  tol=[];
end
[b,a] = tf(Hd);
f = islinphase(b,a,tol);

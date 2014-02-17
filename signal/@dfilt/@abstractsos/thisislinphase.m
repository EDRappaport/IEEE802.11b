function f = thisislinphase(Hd,tol)
%THISISLINPHASE  True for linear phase filter.
%   THISISLINPHASE(Hd) returns 1 if filter Hd is linear phase, and 0 otherwise.
%
%   THISISLINPHASE(Hd,TOL) uses tolerance TOL to determine when two numbers are
%   close enough to be considered equal.
%
%   See also DFILT.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.3.4.4 $  $Date: 2012/09/20 22:34:44 $

if nargin < 2
  tol=[];
end

warnsv(Hd);
[b,a] = tf(Hd);
f = islinphase(b,a,tol);


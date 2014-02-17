function f = thisisallpass(Hd,tol)
%ISALLPASS  True for allpass filter.
%   ISALLPASS(Hd) returns 1 if filter Hd is all-pass, and 0 otherwise.
%
%   ISALLPASS(Hd,TOL) uses tolerance TOL to determine when two numbers are
%   close enough to be considered equal.
%
%   See also DFILT.   
  
%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/09/20 22:34:49 $

% This should be private

if nargin<2
  tol = [];
end
[b,a] = tf(Hd);
f = isallpass(b,a,tol);


function f = thisisminphase(Hd,tol)
%THISISMINPHASE True if minimum phase.
%   THISISMINPHASE(Hd) returns 1 if filter Hd is minimum phase, and 0 otherwise.
%
%   THISISMINPHASE(Hd,TOL) uses tolerance TOL to determine when two numbers are
%   close enough to be considered equal.
%
%   See also DFILT.   
  
%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.3.4.6 $  $Date: 2012/09/20 22:34:46 $
  
if nargin<2; tol=[]; end

warnsv(Hd);

sos = Hd.sosMatrix;
if size(sos,1) < 2
  % Analysis assumes b,a inputs when first input is a vector so make sure
  % we pass in a matrix even if order is 2.
  sos = [sos; [1 0 0 1 0 0]];
end
f = isminphase(sos,tol);


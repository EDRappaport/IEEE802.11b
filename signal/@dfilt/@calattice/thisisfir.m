function f = thisisfir(Hd)
%THISISFIR  True for FIR filter.
%   THISISFIR(Hd) returns 1 if filter Hd is FIR, and 0 otherwise.
%
%   See also DFILT.   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.5 $  $Date: 2002/07/29 21:43:20 $
  
% This should be private

% Since this is composed of all-pole lattices, it is not FIR.
f = false;

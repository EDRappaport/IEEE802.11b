function f = thisisreal(Hd)
%THISISREAL  True for filter with real coefficients.
%   THISISREAL(Hd) returns 1 if filter Hd has real coefficients, and 0
%   otherwise. 
%
%   See also DFILT.   
  
%   Author: Thomas A. Bryan
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.6 $  $Date: 2002/11/21 15:43:07 $
  
% This should be private

f = isreal(Hd.Allpass1) & isreal(Hd.Allpass2) & isreal(Hd.Beta);
function n = thisorder(Hd)
%THISORDER Filter order.
%   THISORDER(Hd) returns the order of filter Hd.
%
%   See also DFILT.   
  
%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2012/09/20 22:34:59 $

% This should be private

[b,a] = tf(Hd);
n = filtord(b,a);

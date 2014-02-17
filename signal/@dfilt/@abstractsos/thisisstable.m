function f = thisisstable(Hd)
%THISISSTABLE  True if filter is stable.
%   THISISSTABLE(Hd) returns 1 if discrete-time filter Hd is stable, and 0
%   otherwise. 
%
%   See also DFILT.   
  
%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.4.4.4 $  $Date: 2012/09/20 22:34:47 $

warnsv(Hd);
sos = Hd.sosMatrix;
if size(sos,1) < 2
  % Analysis assumes b,a inputs when first input is a vector so make sure
  % we pass in a matrix even if order is 2.
  sos = [sos; [1 0 0 1 0 0]];
end
f = isstable(sos);

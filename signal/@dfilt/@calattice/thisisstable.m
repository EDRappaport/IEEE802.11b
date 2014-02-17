function f = thisisstable(Hd)
%THISISSTABLE  True if filter is stable.
%   THISISSTABLE(Hd) returns 1 if discrete-time filter Hd is stable, and 0
%   otherwise. 

%   Author(s): R. Losada, T. Bryan
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.7 $ $Date: 2002/11/21 15:43:06 $

% This should be private

f = thisisstable(Hd.privAllpass1) & thisisstable(Hd.privAllpass2);
            


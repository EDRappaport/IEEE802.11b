function isstableflag = thisisstable(Hd)
%THISISSTABLE  True if filter is stable.
%   THISISSTABLE(Hd) returns 1 if discrete-time filter Hd is stable, and 0
%   otherwise. 

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.4.4.1 $ $Date: 2012/09/20 22:34:53 $

% This should be private

isstableflag = isstable(Hd.Numerator,Hd.Denominator);

    
            


function minfo = measureinfo(this)
%MEASUREINFO   

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/02/21 07:09:16 $

[F, H] = getmask(this);
minfo.Frequencies = F;
minfo.FreqResponse = H;


% [EOF]

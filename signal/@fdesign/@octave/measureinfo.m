function minfo = measureinfo(this)
%MEASUREINFO   

%   Copyright 2006-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2009/10/16 06:41:39 $

[F,A] = getmask(this,maskutils(this,1));
if ~this.NormalizedFrequency
    F = F*(this.Fs/2);
    F(F>this.Fs/2) = [];
else
    F(F>1) = [];
end 
idx = find(isnan(F));
minfo.Frequencies = F(1:idx-1);
minfo.Magnitudes = A(1:idx-1);
minfo.A = A;


% [EOF]

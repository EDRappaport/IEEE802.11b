function sc = cumnorm(Hd,pnorm,secondary)
%CUMNORM   

%   Author(s): R. Losada
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2004/04/12 23:52:11 $

L = nsections(Hd);
Hdc = cumsec(Hd,1:L,secondary);

sc = zeros(1,L);

for n = 1:L,
    sc(n) = norm(Hdc(n),pnorm);
end

% [EOF]

function Hd = dispatch(this)
%DISPATCH   Returns the LWDFILT.

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:23:00 $

den = [1, this.AllpassCoefficients];
num = fliplr(den);

Hd = lwdfilt.tf(num,den);

Hd.refNum = num;
Hd.refDen = den;

% [EOF]

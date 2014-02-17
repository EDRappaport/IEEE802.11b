function ydB = pow2db(y)
%POW2DB   Power to dB conversion
%   YDB = POW2DB(Y) convert the data Y into its corresponding dB value YDB
%
%   % Example:
%   %   Calculate ratio of 2000W to 2W in decibels
%
%   y1 = pow2db(2000/2)     % Answer in db

%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.10.5 $  $Date: 2012/10/29 19:31:50 $

%#codegen
coder.internal.assert(all(y(:)>=0),'signal:pow2db:InvalidInput')

%ydB = 10*log10(y);
%ydB = db(y,'power');
% We want to guarantee that the result is an integer
% if y is a negative power of 10.  To do so, we force
% some rounding of precision by adding 300-300.

ydB = (10.*log10(y)+300)-300;



% [EOF]

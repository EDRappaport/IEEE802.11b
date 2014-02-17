function data=generate(hWIN)
%GENERATE(hWIN) Generates the Chebyshev window
%
%   sigwin.chebwin is not recommended.
%   Use <a href="matlab:help chebwin">chebwin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = chebwin(hWIN.Length, hWIN.SidelobeAtten);

% [EOF]

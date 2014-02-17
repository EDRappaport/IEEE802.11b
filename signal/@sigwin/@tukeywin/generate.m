function data=generate(hWIN)
%GENERATE(hWIN) Generates the Tukey window
%
%   sigwin.tukeywin is not recommended.
%   Use <a href="matlab:help tukeywin">tukeywin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = tukeywin(hWIN.length, hWIN.Alpha);

% [EOF]

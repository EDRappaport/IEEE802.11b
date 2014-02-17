function data=generate(hWIN)
%GENERATE(hWIN) Generates the Kaiser window
%
%   sigwin.kaiser is not recommended.
%   Use <a href="matlab:help kaiser">kaiser</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = kaiser(hWIN.length, hWIN.Beta);

% [EOF]

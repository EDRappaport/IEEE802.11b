function data=generate(hWIN)
%GENERATE(hWIN) Generates the Gaussian window
%
%   sigwin.gausswin is not recommended.
%   Use <a href="matlab:help gausswin">gausswin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = gausswin(hWIN.length, hWIN.Alpha);

% [EOF]

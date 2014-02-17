function data=generate(hWIN)
%GENERATE(hWIN) Generates the Hann window
%
%   sigwin.hann is not recommended.
%   Use <a href="matlab:help hann">hann</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = hann(hWIN.length, hWIN.SamplingFlag);

% [EOF]

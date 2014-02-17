function data=generate(hWIN)
%GENERATE(hWIN) Generates the Hamming window
%
%   sigwin.hamming is not recommended.
%   Use <a href="matlab:help hamming">hamming</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = hamming(hWIN.Length, hWIN.SamplingFlag);

% [EOF]

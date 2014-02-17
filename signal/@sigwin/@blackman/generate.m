function data=generate(hWIN)
%GENERATE(hWIN) Generates the Blackman window
%
%   sigwin.blackman is not recommended.
%   Use <a href="matlab:help blackman">blackman</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = blackman(hWIN.Length, hWIN.SamplingFlag);

% [EOF]

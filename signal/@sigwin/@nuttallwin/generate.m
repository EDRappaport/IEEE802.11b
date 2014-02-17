function data=generate(hWIN)
%GENERATE(hWIN) Generates the Nuttall window
%
%   sigwin.nuttallwin is not recommended.
%   Use <a href="matlab:help nuttallwin">nuttallwin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = nuttallwin(hWIN.length, hWIN.SamplingFlag);

% [EOF]

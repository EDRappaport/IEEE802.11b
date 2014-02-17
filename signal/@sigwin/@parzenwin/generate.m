function data=generate(hWIN)
%GENERATE(hWIN) Generates the Parzen window
%
%   sigwin.parzenwin is not recommended.
%   Use <a href="matlab:help parzenwin">parzenwin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = parzenwin(hWIN.length);

% [EOF]

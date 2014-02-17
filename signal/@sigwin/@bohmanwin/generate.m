function data=generate(hWIN)
%GENERATE(hWIN) Generates the Bohman window
%
%   sigwin.bohmanwin is not recommended.
%   Use <a href="matlab:help bohmanwin">bohmanwin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = bohmanwin(hWIN.length);

% [EOF]

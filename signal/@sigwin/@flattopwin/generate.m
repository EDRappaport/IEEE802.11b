function data = generate(hWIN)
%GENERATE Generates the Flat Top window
%
%   sigwin.flattopwin is not recommended.
%   Use <a href="matlab:help flattopwin">flattopwin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = flattopwin(hWIN.length, hWIN.SamplingFlag);

% [EOF]

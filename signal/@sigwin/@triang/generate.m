function data=generate(hWIN)
%GENERATE(hWIN) Generates the triangular window
%
%   sigwin.triang is not recommended.
%   Use <a href="matlab:help triang">triang</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = triang(hWIN.length);

% [EOF]

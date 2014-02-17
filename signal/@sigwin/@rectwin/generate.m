function data=generate(hWIN)
%GENERATE(hWIN) Generates the rectangular window
%
%   sigwin.rectwin is not recommended.
%   Use <a href="matlab:help rectwin">rectwin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = rectwin(hWIN.length);

% [EOF]

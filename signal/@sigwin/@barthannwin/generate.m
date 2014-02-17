function data=generate(hWIN)
%GENERATE(hWIN) Generates the Bartlett-Hanning window
%
%   sigwin.barthannwin is not recommended.
%   Use <a href="matlab:help barthannwin">barthannwin</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = barthannwin(hWIN.length);

% [EOF]

function data=generate(hWIN)
%GENERATE(hWIN) Generates the Bartlett window
%
%   sigwin.bartlett is not recommended.
%   Use <a href="matlab:help bartlett">bartlett</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = bartlett(hWIN.length);

% [EOF]

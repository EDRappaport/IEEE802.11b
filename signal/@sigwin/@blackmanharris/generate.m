function data=generate(hWIN)
%GENERATE(hWIN) Generates the Blackman-Harris window
%
%   sigwin.blackmanharris is not recommended.
%   Use <a href="matlab:help blackmanharris">blackmanharris</a> instead.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

data = blackmanharris(hWIN.length, hWIN.SamplingFlag);

% [EOF]

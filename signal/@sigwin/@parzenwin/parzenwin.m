function hWIN = parzenwin(n)
%PARZENWIN Construct a Parzen window object
%
%   SIGWIN.PARZENWIN is not recommended.  Use <a href="matlab:help parzenwin">parzenwin</a> instead.
%
%   H = SIGWIN.PARZENWIN(N) constructs a Parzen window object with length
%   N.  If N is not specified, it defaults to 64.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.parzenwin;
hWIN.Name = 'Parzen';

if nargin>0,
    hWIN.length = n;
end

% [EOF]

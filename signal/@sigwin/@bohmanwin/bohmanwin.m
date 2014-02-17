function hWIN = bohmanwin(n)
%BOHMANWIN Construct a Bohman window object
%
%   SIGWIN.BOHMANWIN is not recommended.  Use <a href="matlab:help bohmanwin">bohmanwin</a> instead.
%
%   H = SIGWIN.BOHMANWIN(N) constructs a Bohman window object with length
%   N. If N is not specified, it defaults to 64.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.bohmanwin;
hWIN.Name = 'Bohman';

if nargin>0,
    hWIN.length = n;
end

% [EOF]

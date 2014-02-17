function hWIN = kaiser(n, param)
%KAISER Construct a Kaiser object
%
%   SIGWIN.KAISER is not recommended. Use <a href="matlab:help kaiser">kaiser</a> instead.
%
%   H = SIGWIN.KAISER(N, B) constructs a Kaiser window object with length N
%   and Beta B.  If N or B is not specified, they default to 64 and .5
%   respectively.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.kaiser;
hWIN.Name = 'Kaiser';
createdynamicprops(hWIN, 'Beta', 'double','Beta');

if nargin>0,
    hWIN.length = n;
end

if nargin>1,
    hWIN.Beta = param;
else
    hWIN.Beta = 0.5;
end

% [EOF]

function hWIN = rectwin(n)
%RECTWIN Construct a Rectangular window object
%
%   SIGWIN.RECTWIN is not recommended.  Use <a href="matlab:help rectwin">rectwin</a> instead.
%
%   H = SIGWIN.RECTWIN(N) constructs a Rectangular window object with length
%   N.  If N is not specified, it defaults to 64.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.rectwin;
hWIN.Name = 'Rectangular';

if nargin>0,
    hWIN.length = n;
end

% [EOF]

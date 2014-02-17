function hWIN = triang(n)
%TRIANG Construct a Triangular window object
%
%   SIGWIN.TRIANG is not recommended.  Use <a href="matlab:help triang">triang</a> instead.
%
%   H = SIGWIN.TRIANG(N) constructs a Triangular window object with length
%   N.  If N is not specified, it defaults to 64.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.triang;
hWIN.Name = 'Triangular';

if nargin>0,
    hWIN.length = n;
end

% [EOF]

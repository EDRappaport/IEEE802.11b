function hWIN = blackman(n, sflag)
%BLACKMAN Construct a Blackman window object
%
%   SIGWIN.BLACKMAN is not recommended.  Use <a href="matlab:help blackman">blackman</a> instead.
%
%   H = SIGWIN.BLACKMAN(N, S) constructs a Blackman window object with
%   length N and sampling flag S.  If N or S is not specified, they default
%   to 64 and 'symmetric' respectively.  The sampling flag can also be
%   'periodic'.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.blackman;
hWIN.Name = 'Blackman';

if nargin>0,
    hWIN.length = n;
end

if nargin>1,
    hWIN.SamplingFlag = sflag;
end

% [EOF]

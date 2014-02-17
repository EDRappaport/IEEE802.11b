function hWIN = blackmanharris(n)
%BLACKMANHARRIS Construct a Blackman-Harris window object
%
%   SIGWIN.BLACKMANHARRIS is not recommended.  Use <a href="matlab:help blackmanharris">blackmanharris</a> instead.
%
%   H = SIGWIN.BLACKMANHARRIS(N) constructs a Blackman-Harris window object
%   with length N.  If N is not specified, it defaults to 64.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.blackmanharris;
hWIN.Name = 'Blackman-Harris';

if nargin>0,
    hWIN.length = n;
end

% [EOF]

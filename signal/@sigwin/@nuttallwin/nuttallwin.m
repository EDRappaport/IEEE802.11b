function hWIN = nuttallwin(n)
%NUTTALLWIN Construct a Nuttall defined minimum 4-term Blackman-Harris window object
%
%   SIGWIN.NUTTALLWIN is not recommended.  Use <a href="matlab:help nuttallwin">nuttallwin</a> instead.
%
%   H = SIGWIN.NUTTALLWIN(N) constructs a Nuttall defined minimum 4-term
%   Blackman-Harris window object with length N.  If N is not specified, it
%   defaults to 64.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.nuttallwin;
hWIN.Name = 'Nuttall';

if nargin>0,
    hWIN.length = n;
end

% [EOF]

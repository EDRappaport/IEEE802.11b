function hWIN = tukeywin(n, param)
%TUKEYWIN Construct a Tukey object
%
%   SIGWIN.TUKEYWIN is not recommended.  Use <a href="matlab:help tukeywin">tukeywin</a> instead.
%
%   H = SIGWIN.TUKEYWIN(N, A) constructs a Tukey window object with length
%   N and Alpha A.  If N or A is not specified, they default to 64 and .5
%   respectively.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.tukeywin;
hWIN.Name = 'Tukey';
createdynamicprops(hWIN, 'Alpha', 'double','Alpha');

if nargin>0,
    hWIN.length = n;
end

if nargin>1,
    hWIN.Alpha = param;
else
    hWIN.Alpha = 0.5;
end

% [EOF]

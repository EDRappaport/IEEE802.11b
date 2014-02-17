function hWIN = gausswin(n, param)
%GAUSSWIN Construct a Gaussian object
%
%   SIGWIN.GAUSSWIN is not recommended.  Use <a href="matlab:help gausswin">gausswin</a> instead.
%
%   H = SIGWIN.GAUSSWIN(N, A) constructs a Gaussian window object with
%   length N and Alpha A.  If N or A is not specified, they default to 64
%   and 2.5 respectively.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.gausswin;
hWIN.Name = 'Gaussian';
createdynamicprops(hWIN, 'Alpha', 'double','Alpha');

if nargin>0,
    hWIN.length = n;
end

if nargin>1,
    hWIN.Alpha = param;
else
    hWIN.Alpha = 2.5;
end

% [EOF]

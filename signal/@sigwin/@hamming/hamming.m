function hWIN = hamming(n, sflag)
%HAMMING Construct a Hamming window object
%
%   SIGWIN.HAMMING is not recommended.  Use <a href="matlab:help hamming">hamming</a> instead.
%
%   H = SIGWIN.HAMMING(N, S) constructs a Hamming window object with length
%   N and sampling flag S.  If N or S is not specified, they default to 64
%   and 'symmetric' respectively.  The sampling flag can also be
%   'periodic'.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.hamming;
hWIN.Name = 'Hamming';

if nargin > 0, hWIN.Length       = n;     end
if nargin > 1, hWIN.SamplingFlag = sflag; end

% [EOF]

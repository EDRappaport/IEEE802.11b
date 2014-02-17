function hWIN = hann(n, sflag)
%HANN Construct a Hann window object
%
%   SIGWIN.HANN is not recommended.  Use <a href="matlab:help hann">hann</a> instead.
%
%   H = SIGWIN.HANN(N, S) constructs a Hann window object with length N and
%   sampling flag S.  If N or S is not specified, they default to 64 and
%   'symmetric' respectively.  The sampling flag can also be 'periodic'.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.hann;
hWIN.Name = 'Hann';

if nargin > 0, hWIN.Length       = n;     end
if nargin > 1, hWIN.SamplingFlag = sflag; end

% [EOF]

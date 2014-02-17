function this = flattopwin(n, sflag)
%FLATTOPWIN Construct a Flat Top window object
%
%   SIGWIN.FLATTOPWIN is not recommended.  Use <a href="matlab:help flattopwin">flattopwin</a> instead.
%
%   H = SIGWIN.FLATTOPWIN(N, S) constructs a Flat Top window object with length N
%   and sampling flag S.  If N or S is not specified, they default to 64 and
%   'symmetric' respectively.  The sampling flag can also be 'periodic'.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

this = sigwin.flattopwin;
this.Name = 'Flat Top';

if nargin > 0, this.Length       = n;     end
if nargin > 1, this.SamplingFlag = sflag; end

% [EOF]

function this = diffordmbap(varargin)
%DIFFORDMBAP Construct a DIFFORDMBAP object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:58 $

this = fspecs.diffordmbap;

this.ResponseType = 'Multi-band Differentiator with filter order';

% Defaults
this.FilterOrder = 30;
this.Fpass = .7;
this.Fstop = .9;  
this.Apass = 1;

this.setspecs(varargin{:});

% [EOF]

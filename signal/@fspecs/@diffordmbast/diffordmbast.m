function this = diffordmbast(varargin)
%DIFFORDMBAST Construct a DIFFORDMBAST object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:04 $

this = fspecs.diffordmbast;

this.ResponseType = 'Multi-band Differentiator with filter order';

% Defaults
this.FilterOrder = 30;
this.Fpass = .7;
this.Fstop = .9;  
this.Astop = 60;

this.setspecs(varargin{:});

% [EOF]

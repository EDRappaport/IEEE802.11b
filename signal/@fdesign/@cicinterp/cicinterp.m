function this = cicinterp(varargin)
%CICINTERP   Construct a CICINTERP object.

%   Author(s): P. Costa
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:23:25 $

this = fdesign.cicinterp;

set(this, 'Response', 'CIC Interpolator');

this.setspecs(varargin{:});

% [EOF]

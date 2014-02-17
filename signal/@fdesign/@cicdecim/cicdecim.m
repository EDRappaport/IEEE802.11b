function this = cicdecim(varargin)
%CICDECIM   Construct a CICDECIM object.

%   Author(s): P. Costa
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:23:19 $

this = fdesign.cicdecim;

set(this, 'Response', 'CIC Decimator');

this.setspecs(varargin{:});

% [EOF]

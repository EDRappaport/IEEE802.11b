function varargout = multisection(this, varargin)
%DESIGN   Design the CIC filter.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/30 17:33:46 $

[varargout{1:nargout}] = privdesigngateway(this, 'multisection',...
    this.DifferentialDelay, varargin{:});

% [EOF]

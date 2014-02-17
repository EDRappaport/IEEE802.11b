function varargout = firls(this, varargin)
%FIRLS   Design a least-squares filter.   

%   Author(s): J. Schickler
%   Copyright 1999-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2011/05/13 18:12:06 $

try
    [varargout{1:nargout}] = privdesigngateway(this, 'firls', varargin{:});
catch e
    throw(e);
end

% [EOF]

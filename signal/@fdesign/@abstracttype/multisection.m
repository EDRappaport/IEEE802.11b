function varargout = multisection(this, varargin)
%MULTISECTION   

%   Author(s): J. Schickler
%   Copyright 2005-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:12:19 $

try
    [varargout{1:nargout}] = privdesigngateway(this, 'multisection', varargin{:});
catch e
    throw(e);
end

% [EOF]

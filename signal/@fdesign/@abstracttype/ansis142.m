function varargout = ansis142(this,varargin)
%ANSIS142   

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/05/13 18:11:57 $

try
    [varargout{1:nargout}] = privdesigngateway(this, 'ansis142', varargin{:});
catch e
    throw(e);
end

% [EOF]

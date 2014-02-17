function varargout = bell41009(this,varargin)
%BELL41009   

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/05/13 18:11:58 $

try
    [varargout{1:nargout}] = privdesigngateway(this, 'bell41009', varargin{:});
catch e
    throw(e);
end

% [EOF]

function varargout = freqsamp(this,varargin)
%FREQSAMP   

%   Author(s): V. Pellissier
%   Copyright 2005-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:12:08 $

try
    [varargout{1:nargout}] = privdesigngateway(this, 'freqsamp', varargin{:});
catch e
    throw(e);
end


% [EOF]

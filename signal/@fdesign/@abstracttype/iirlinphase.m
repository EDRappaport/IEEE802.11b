function varargout = iirlinphase(this,varargin)
%IIRLINPHASE   

%   Author(s): R. Losada
%   Copyright 2005-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:12:12 $

try
    [varargout{1:nargout}] = privdesigngateway(this, 'iirlinphase', varargin{:});
catch e
    throw(e);
end



% [EOF]

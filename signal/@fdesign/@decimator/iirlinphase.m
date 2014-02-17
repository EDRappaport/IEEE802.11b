function varargout = iirlinphase(this,varargin)
%IIRLINPHASE   

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2011/05/13 18:12:33 $

validate_iir_designmethod(this,'IIR linear phase')

try
    [varargout{1:nargout}] = privdesigngateway(this, 'iirlinphase', ...
        'DesignMode','Decimator',varargin{:});
catch e
    throw(e);
end



% [EOF]

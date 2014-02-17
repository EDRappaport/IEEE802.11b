function varargout = cheby1(this, varargin)
%CHEBY1   Chebyshev Type I digital filter design.
%   H = CHEBY1(D) Design a Chebyshev Type I digital filter using the
%   specifications in the object D.
%
%   H = CHEBY1(D, MATCH) Design a filter and match one band exactly.  MATCH
%   can be either 'passband' (default) or 'stopband'.  This flag is only
%   used when designing minimum order Chebyshev filters.

%   Author(s): J. Schickler
%   Copyright 1999-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2011/05/13 18:12:01 $

try
    [varargout{1:nargout}] = privdesigngateway(this, 'cheby1', varargin{:});
catch e
    throw(e);
end


% [EOF]

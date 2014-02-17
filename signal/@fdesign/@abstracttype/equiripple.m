function varargout = equiripple(this, varargin)
%EQUIRIPPLE   Design an equiripple filter.
%   EQUIRIPPLE(D) designs an equiripple filter using the specifications in
%   the object D.

%   Author(s): J. Schickler
%   Copyright 1999-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2011/05/13 18:12:04 $

try
    [varargout{1:nargout}] = privdesigngateway(this, 'equiripple', varargin{:});
catch e
    throw(e);
end

% [EOF]

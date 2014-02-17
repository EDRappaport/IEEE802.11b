function setspecs(this, M, varargin)
%SETSPECS   Set the specs.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:20:50 $

if nargin > 1
    set(this, 'DifferentialDelay', M);
end

abstract_setspecs(this, varargin{:});

% [EOF]

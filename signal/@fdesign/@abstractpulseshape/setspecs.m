function setspecs(this, sps, varargin)
%SETSPECS Set the specs
%   OUT = SETSPECS(ARGS) <long description>

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:07:53 $

if nargin < 2
    return;
end

if ischar(sps)
    error(message('signal:fdesign:abstractpulseshape:setspecs:invalidInput'));
end

set(this, 'SamplesPerSymbol', sps);

abstract_setspecs(this, varargin{:});

% [EOF]

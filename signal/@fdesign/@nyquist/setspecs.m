function setspecs(this, B, varargin)
%SETSPECS   Set the specs.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:41 $

if nargin < 2
    return;
end

if ischar(B)
    error(message('signal:fdesign:nyquist:setspecs:invalidInput'));
end

set(this, 'Band', B);

abstract_setspecs(this, varargin{:});

% [EOF]

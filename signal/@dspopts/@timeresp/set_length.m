function le = set_length(this, le)
%SET_LENGTH   PreSet function for the 'length' property.

%   Author(s): J. Schickler
%   Copyright 2004 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:07:43 $

if le < 1
    error(message('signal:dspopts:timeresp:set_length:invalidLength'));
end

set(this, 'LengthOption', 'Specified', ...
    'privLength', le);

le = [];

% [EOF]

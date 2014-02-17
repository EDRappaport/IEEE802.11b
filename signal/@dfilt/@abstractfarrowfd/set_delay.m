function delay = set_delay(this, delay)
%SET_DELAY   PreSet function for the 'delay' property.

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:09:08 $

if delay<0,
    error(message('signal:dfilt:abstractfarrowfd:set_delay:expectPositive', 'Delay'));
end

if delay>1,
    error(message('signal:dfilt:abstractfarrowfd:set_delay:expectLessThan', 'Delay'));
end

if ~isreal(delay),
    error(message('signal:dfilt:abstractfarrowfd:set_delay:expectReal', 'Delay'));
end


delay = super_set_delay(this, delay);

% [EOF]

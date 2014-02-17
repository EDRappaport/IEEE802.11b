function Hd = tolatticear(this)
%TOLATTICEAR   Convert to a latticear filter.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/12/06 00:06:55 $

[b,a] = tf(this);

% Remove all trailing zeros.
indx = find(b~=0, 1, 'last');
b(indx+1:end) = [];

% If the numerator is a scalar we can convert.
if numel(b) == 1 & b == 1 %#ok

    [k,v] = tf2latc(b,a);
    Hd    = dfilt.latticear(k);
else
    error(message('signal:dfilt:singleton:tolatticear:NotSupported'));
end

% [EOF]

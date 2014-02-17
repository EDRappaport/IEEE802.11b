function h = toallpass(this)
%TOALLPASS   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:06:45 $

if isallpass(this),
    [b,a] = tf(this);
    h = dfilt.allpass(a(2:end));
else
       error(message('signal:dfilt:singleton:toallpass:notAllpass'));
end

% [EOF]

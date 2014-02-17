function h = towdfallpass(this)
%TOWDFALLPASS   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:06:59 $

if isallpass(this),
    [b,a] = tf(this);
    h = dfilt.wdfallpass(a(2:end));
else
       error(message('signal:dfilt:singleton:towdfallpass:notAllpass'));
end

% [EOF]

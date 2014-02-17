function data=generate(hWIN)
%GENERATE(hWIN) Generates the userdefined window

%   Author(s): V.Pellissier
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.3.4.2 $  $Date: 2010/12/06 00:11:49 $

try
data = evalin('base', hWIN.MATLAB_expression);
catch
error(message('signal:sigwin:userdefined:generate:InvalidParam'));
end
% [EOF]

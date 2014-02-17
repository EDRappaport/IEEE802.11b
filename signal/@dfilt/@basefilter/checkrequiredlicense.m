function checkrequiredlicense(Hd,hTar)
%CHECKREQUIREDLICENSE check required license for realizemdl

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/05/13 18:09:33 $

% Check if Simulink is installed
[b, ~, ~, errObj] = issimulinkinstalled;
if ~b
    error(errObj);
end

% [EOF]

function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Copyright 2005-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/12/27 01:20:33 $

switch lower(this.Specification)
    case 'n,f,gd',
        defaultmethod = 'iirlpnorm';
    case 'n,b,f,gd', 
        defaultmethod = 'iirlpnorm';
  otherwise
      error(message('signal:fdesign:arbgrpdelay:getdefaultmethod:InternalError'));      
end

% [EOF]

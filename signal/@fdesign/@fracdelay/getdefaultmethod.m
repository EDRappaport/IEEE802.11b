function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:25 $

switch this.Specification,
    case 'N',
        defaultmethod = 'lagrange';
    otherwise,
        error(message('signal:fdesign:fracdelay:getdefaultmethod:InternalError'));
end


% [EOF]

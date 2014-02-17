function defaultmethod = getdefaultmethod(this)
%GETDEFAULTMETHOD   Get the defaultmethod.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:07 $

switch this.Specification,
    case 'N,F,H',
        defaultmethod = 'freqsamp';
    case 'Nb,Na,F,H', 
        defaultmethod = 'iirls';
    case 'N,B,F,H', 
        defaultmethod = 'firls';
    otherwise,
        error(message('signal:fdesign:arbmagnphase:getdefaultmethod:InternalError'));
end

% [EOF]

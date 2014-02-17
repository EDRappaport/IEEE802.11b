function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/12/06 00:08:06 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n,f,h',
        %#function fspecs.sbarbmagnphase
        cSpecCon = 'fspecs.sbarbmagnphase';
    case 'nb,na,f,h',
        %#function fspecs.sbarbmagnphaseiir
        cSpecCon = 'fspecs.sbarbmagnphaseiir';
    case 'n,b,f,h'
        %#function fspecs.multibandmagnphase
        cSpecCon = 'fspecs.multibandmagnphase';
    otherwise
        error(message('signal:fdesign:arbmagnphase:getconstructor:internalError'));
end

% [EOF]

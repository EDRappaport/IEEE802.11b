function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:24 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n',
        %#function fspecs.fdword
        cSpecCon = 'fspecs.fdword';
    otherwise
        error(message('signal:fdesign:fracdelay:getconstructor:internalError'));
end


% [EOF]


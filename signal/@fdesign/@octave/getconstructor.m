function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:42 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n,f0',
        %#function fspecs.octavewordncenterfreq
        cSpecCon = 'fspecs.octavewordncenterfreq';
    otherwise
        error(message('signal:fdesign:octave:getconstructor:internalError'));
end


% [EOF]


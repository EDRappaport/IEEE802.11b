function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/12/27 01:20:32 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n,f,gd',
        %#function fspecs.sbarbgrpdelay
        cSpecCon = 'fspecs.sbarbgrpdelay';
    case 'n,b,f,gd'
        %#function fspecs.multibandarbgrpdelay
        cSpecCon = 'fspecs.multibandarbgrpdelay';
  otherwise
      error(message('signal:fdesign:arbgrpdelay:getconstructor:internalError'));      
end

% [EOF]

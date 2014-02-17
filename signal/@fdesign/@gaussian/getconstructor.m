function cSpecCon = getconstructor(this)
%GETCONSTRUCTOR Return the constructor for the specification type.

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:27 $


if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'nsym,bt',
        %#function fspecs.psgaussnsym
        cSpecCon = 'fspecs.psgaussnsym';
    otherwise
        error(message('signal:fdesign:gaussian:getconstructor:internalError'));
end

% [EOF]

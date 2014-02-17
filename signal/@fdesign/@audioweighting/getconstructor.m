function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Get the constructor.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:08 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'wt',
        %#function fspecs.audioweightingwt
        cSpecCon = 'fspecs.audioweightingwt';
    case 'wt,class',
        %#function fspecs.audioweightingwtclass
        cSpecCon = 'fspecs.audioweightingwtclass';        
    otherwise
        error(message('signal:fdesign:audioweighting:getconstructor:internalError'));
end


% [EOF]


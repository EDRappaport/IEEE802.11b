function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Return the constructor for the specification type.

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:14 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n,q',
        %#function fspecs.combq
        cSpecCon = 'fspecs.combq'; 
    case 'n,bw',
        %#function fspecs.combbw
        cSpecCon = 'fspecs.combbw'; 
    case 'l,bw,gbw,nsh',
        %#function fspecs.comblbwgbwnsh
        cSpecCon = 'fspecs.comblbwgbwnsh';         
    otherwise
        error(message('signal:fdesign:comb:getconstructor:internalError'));
end

% [EOF]

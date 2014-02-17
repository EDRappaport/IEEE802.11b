function cSpecCon = getconstructor(this, stype)
%GETCONSTRUCTOR   Return the constructor for the specification type.

%   Author(s): R. Losada
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:08:39 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'n,f0,q',
        %#function fspecs.notchq
        cSpecCon = 'fspecs.notchq'; 
    case 'n,f0,q,ap',
        %#function fspecs.notchqap
        cSpecCon = 'fspecs.notchqap'; 
    case 'n,f0,q,ast',
        %#function fspecs.notchqast
        cSpecCon = 'fspecs.notchqast';         
    case 'n,f0,q,ap,ast',
        %#function fspecs.notchqapast
        cSpecCon = 'fspecs.notchqapast';                        
    case 'n,f0,bw',
        %#function fspecs.notchbw
        cSpecCon = 'fspecs.notchbw';                        
    case 'n,f0,bw,ap',
        %#function fspecs.notchbwap
        cSpecCon = 'fspecs.notchbwap';                        
    case 'n,f0,bw,ast',
        %#function fspecs.notchbwast
        cSpecCon = 'fspecs.notchbwast';                        
    case 'n,f0,bw,ap,ast',
        %#function fspecs.notchbwapast
        cSpecCon = 'fspecs.notchbwapast';                
    otherwise
        error(message('signal:fdesign:notch:getconstructor:internalError'));
end

% [EOF]

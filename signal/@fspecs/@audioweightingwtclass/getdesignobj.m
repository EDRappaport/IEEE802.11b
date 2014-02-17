function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the design object.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/01/06 22:58:23 $

switch lower(this.WeightingType)
    case 'a'
        %#function fdfmethod.ansis142audioweighta
        designobj.ansis142 = 'fdfmethod.ansis142audioweighta';
    case 'c'
        %#function fdfmethod.ansis142audioweightc
        designobj.ansis142 = 'fdfmethod.ansis142audioweightc';
end

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

function designobj = getdesignobj(~, str)
%GETDESIGNOBJ  Get the designobj.

%   Copyright 1988-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2011/04/02 00:56:39 $

%#function fmethod.eqripbs
%#function fmethod.firlsbs
designobj.equiripple = 'fmethod.eqripbs';
designobj.firls      = 'fmethod.firlsbs';

if isfdtbxinstalled
    %#function fdfmethod.lpnormbs1
    designobj.iirlpnorm  = 'fdfmethod.lpnormbs1';
    %#function fdfmethod.eqripbs
    designobj.equiripple = 'fdfmethod.eqripbs';
end

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

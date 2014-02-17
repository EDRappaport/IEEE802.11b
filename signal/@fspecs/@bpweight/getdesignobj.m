function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the designobj.

%   Copyright 1988-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2011/04/02 00:56:24 $

%#function fmethod.eqripbp
%#function fmethod.firlsbp
designobj.equiripple = 'fmethod.eqripbp';
designobj.firls      = 'fmethod.firlsbp';

if isfdtbxinstalled
    %#function fdfmethod.lpnormbp1
    designobj.iirlpnorm  = 'fdfmethod.lpnormbp1';
    %#function fdfmethod.eqripbp
    designobj.equiripple = 'fdfmethod.eqripbp';
end

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

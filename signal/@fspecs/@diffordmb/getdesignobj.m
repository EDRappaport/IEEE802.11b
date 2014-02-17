function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the designobj.

%   Copyright 2008-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/04/02 00:56:54 $

%#function fmethod.firlsdiffordmb
designobj.firls = 'fmethod.firlsdiffordmb';

if isfdtbxinstalled
   %#function fdfmethod.eqripdiffordmb
    designobj.equiripple = 'fdfmethod.eqripdiffordmb';
else
   %#function fmethod.eqripdiffordmb
    designobj.equiripple = 'fmethod.eqripdiffordmb';
end

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

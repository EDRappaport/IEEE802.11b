function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the designobj.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:46 $

%#function fdfmethod.eqripbsconstrained
designobj.equiripple = 'fdfmethod.eqripbsconstrained';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

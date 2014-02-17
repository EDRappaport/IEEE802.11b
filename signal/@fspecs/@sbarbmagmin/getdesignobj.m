function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/21 07:09:43 $

%#function fdfmethod.eqripsbarbmagmin
designobj.equiripple = 'fdfmethod.eqripsbarbmagmin';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

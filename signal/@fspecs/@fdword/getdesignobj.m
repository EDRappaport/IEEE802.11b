function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the design object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/02/21 07:09:19 $

%#function fdfmethod.lagrange
designobj.lagrange = 'fdfmethod.lagrange';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

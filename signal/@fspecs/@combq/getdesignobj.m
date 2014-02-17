function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the design object.

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/01/06 22:58:26 $

%#function fdfmethod.buttercombq

designobj.butter = 'fdfmethod.buttercombq';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

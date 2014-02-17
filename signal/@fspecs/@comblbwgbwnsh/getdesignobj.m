function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the design object.

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/01/06 22:58:25 $

%#function fdfmethod.buttercomblbwgbwnsh

designobj.butter = 'fdfmethod.buttercomblbwgbwnsh';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

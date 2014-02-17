function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/01/06 22:58:40 $

%#function fdfmethod.lpnormsbarbgrpdelay
designobj.iirlpnorm = 'fdfmethod.lpnormsbarbgrpdelay';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

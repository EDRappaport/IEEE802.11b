function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the design object.

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/01/06 22:58:31 $

%#function fdfmethod.butteroctave
designobj.butter = 'fdfmethod.butteroctave';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

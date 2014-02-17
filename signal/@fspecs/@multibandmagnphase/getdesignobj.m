function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the design object.

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/01/06 22:58:30 $

%#function fmethod.firlsmultibandarbmagnphase
designobj.firls = 'fmethod.firlsmultibandarbmagnphase';
%#function fmethod.eqripmultibandarbmagnphase
designobj.equiripple = 'fmethod.eqripmultibandarbmagnphase';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/04/02 00:57:59 $

if this.privInvSincParamsTunableFlag
  %#function fdfmethod.eqriplpcutoffisincwparams
  designobj.equiripple = 'fdfmethod.eqriplpcutoffisincwparams';
else
  %#function fdfmethod.eqriplpcutoffisinc
  designobj.equiripple = 'fdfmethod.eqriplpcutoffisinc';
end

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

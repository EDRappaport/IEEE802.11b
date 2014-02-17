function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/04/02 00:58:04 $

if this.privInvSincParamsTunableFlag
  %#function fdfmethod.eqriplpminisincwparams
  designobj.equiripple = 'fdfmethod.eqriplpminisincwparams';
else
  %#function fdfmethod.eqriplpminisinc
  designobj.equiripple = 'fdfmethod.eqriplpminisinc';
end
if nargin > 1
  designobj = designobj.(str);
end

% [EOF]

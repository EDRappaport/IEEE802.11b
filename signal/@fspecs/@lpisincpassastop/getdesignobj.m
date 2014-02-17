function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/04/02 00:58:08 $

if this.privInvSincParamsTunableFlag
  %#function fdfmethod.eqriplpastopisincwparams
  designobj.equiripple = 'fdfmethod.eqriplpastopisincwparams';
else
  %#function fdfmethod.eqriplpastopisinc
  designobj.equiripple = 'fdfmethod.eqriplpastopisinc';
end
if nargin > 1
  designobj = designobj.(str);
end

% [EOF]

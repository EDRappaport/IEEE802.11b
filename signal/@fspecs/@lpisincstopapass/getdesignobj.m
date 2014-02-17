function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/04/02 00:58:12 $

if this.privInvSincParamsTunableFlag
  %#function fdfmethod.eqriplpapassisincwparams
  designobj.equiripple = 'fdfmethod.eqriplpapassisincwparams';
else
  %#function fdfmethod.eqriplpapassisinc
  designobj.equiripple = 'fdfmethod.eqriplpapassisinc';
end

if nargin > 1
  designobj = designobj.(str);
end

% [EOF]

function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:57:41 $

%#function fdfmethod.eqriphpapassisinc
designobj.equiripple = 'fdfmethod.eqriphpapassisinc';

if nargin > 1
  designobj = designobj.(str);
end

% [EOF]

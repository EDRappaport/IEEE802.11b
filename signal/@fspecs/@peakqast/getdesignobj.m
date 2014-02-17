function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the design object.

%   Author(s): J. Schickler
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:27:40 $

%#function fdfmethod.cheby2peakq

designobj.cheby2 = 'fdfmethod.cheby2peakq';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]

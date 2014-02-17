function refcoeffs = setrefcoeffs(this, refcoeffs)
%SETREFCOEFFS   Set the refcoeffs.

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:27 $

validaterefcoeffs(this.filterquantizer, 'Coefficients', refcoeffs);

% [EOF]

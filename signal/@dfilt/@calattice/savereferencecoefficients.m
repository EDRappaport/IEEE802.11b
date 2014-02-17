function s = savereferencecoefficients(this)
%SAVEREFERENCECOEFFICIENTS   Save the reference coefficients.

%   Author(s): J. Schickler
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2004/12/26 22:04:18 $

s.refAllpass1 = get(this, 'refAllpass1');
s.refAllpass2 = get(this, 'refAllpass2');
s.refBeta     = get(this, 'refBeta');

% [EOF]

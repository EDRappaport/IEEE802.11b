function coeffs = set_coeffs(this, coeffs)
%SET_COEFFS   PreSet function for the 'coeffs' property.

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:09:05 $

% Always convert to row vector
coeffs = coeffs(:).';

% Check that coeffs are valid
validate_coeffs(this,coeffs);

% Make sure to clear metadata
clearmetadata(this);

% Set the reference coefficients
this.refallpasscoeffs = coeffs;

oldncoeffs = length(this.AllpassCoefficients);

% Quantize the coefficients
quantizecoeffs(this);

% If number of coeffs changes, flush states
if  oldncoeffs~= length(coeffs),
    reset(this);
end

% Hold an empty to not duplicate storage
coeffs = [];

% [EOF]

function coeffs = get_coeffs(this, coeffs)
%GET_COEFFS   PreGet function for the 'coeffs' property.

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:23:02 $

% Use getnumerator since it simply casts to double
coeffs = getnumerator(this.filterquantizer, this.privallpasscoeffs);

% [EOF]

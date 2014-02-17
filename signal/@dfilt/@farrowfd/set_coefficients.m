function c = set_coefficients(this, c)
%SET_COEFFICIENTS   PreSet function for the 'coefficients' property.

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:06:00 $

if size(c,2)<2,
    error(message('signal:dfilt:farrowfd:set_coefficients:InvalidCoefficients'));
end

% Polynomes stored in rows
this.ncoeffs = size(c,1);
reset(this);

this.refcoeffs = c;

% Quantize the coefficients
quantizecoeffs(this);

c = [];

% [EOF]

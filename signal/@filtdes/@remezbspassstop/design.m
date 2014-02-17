function Hd = design(h,d)
%DESIGN  Method to design the filter given the specs.

%   Author(s): R. Losada, J. Schickler
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.3.4.3 $  $Date: 2010/12/06 00:09:54 $

args = getarguments(h, d);

N = get(d, 'Order');

% Check for valid order
if rem(N, 2),
    error(message('signal:filtdes:remezbspassstop:design:MustBeEven'));
end

dens = get(d,'DensityFactor');

b = remez(N, args{:}, {dens});

% Construct object
Hd = dfilt.dffir(b);

% [EOF]

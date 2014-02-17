function quantizecoeffs(h,eventData)
% Quantize coefficients


%   Author(s): R. Losada
%   Copyright 1988-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:15 $

if isempty(h.refcoeffs)
    return;
end

% Quantize the coefficients
h.privcoeffs = quantizecoeffs(h.privfilterquantizer,h.refcoeffs);

setmaxprod(h.filterquantizer, h);
setmaxsum(h.filterquantizer, h);

% [EOF]

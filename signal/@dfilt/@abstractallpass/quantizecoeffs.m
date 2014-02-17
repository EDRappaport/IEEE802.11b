function quantizecoeffs(this,eventData)
%QUANTIZECOEFFS   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:23:07 $

if isempty(this.refallpasscoeffs),
    return;
end

% Quantize the coefficients
this.privallpasscoeffs = quantizecoeffs(this.filterquantizer,this.refallpasscoeffs);

% [EOF]

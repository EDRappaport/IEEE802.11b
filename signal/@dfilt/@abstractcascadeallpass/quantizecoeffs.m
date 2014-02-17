function quantizecoeffs(this)
%QUANTIZECOEFFS   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:23:22 $

if isempty(this.refallpasscoeffs),
    return;
end

% Quantize the coefficients
for k = 1:length(this.refallpasscoeffs),
    this.privallpasscoeffs{k} = quantizecoeffs(this.filterquantizer,this.refallpasscoeffs{k});
end


% [EOF]

function quantizefd(this,eventdata)
%QUANTIZEFD   

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:16 $

if isempty(this.reffracdelay)
    return;
end

% Quantize the coefficients
this.privfracdelay = quantizefd(this.filterquantizer,this.reffracdelay);


% [EOF]

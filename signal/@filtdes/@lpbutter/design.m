function varargout = design(h,d) %#ok<INUSL>
%DESIGN  Method to design the filter given the specs.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.3.4.7 $  $Date: 2012/09/20 22:35:28 $

if nargout == 1,
    hfdesign = fdesign.lowpass('N,F3dB', d.Order, d.Fc);
    Hd       = butter(hfdesign);
    
    varargout = {Hd};
else
    [z,p,k] = butter(d.Order, d.Fc);
    
    varargout = {z,p,k};
end

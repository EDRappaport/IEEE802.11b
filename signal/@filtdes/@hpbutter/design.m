function varargout = design(h,d) %#ok<INUSL>
%DESIGN  Method to design the filter given the specs.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.3.4.7 $  $Date: 2012/09/20 22:35:27 $

if nargout == 1,
    hfdesign = fdesign.highpass('N,F3dB', d.Order, d.Fc);
    Hd       = butter(hfdesign);
    
    varargout = {Hd};
else

    % Set up design params
    N = get(d,'order');

    % Get frequency specs, they have been prenormalized
    Fc = get(d,'Fc');

    [z,p,k] = butter(N,Fc,'high');

    varargout = {z,p,k};
end

% [EOF]

function Hd = design(h,d) %#ok<INUSL>
%DESIGN  Method to design the filter given the specs.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.3.4.1 $  $Date: 2012/09/20 22:35:29 $


% Set up design params
Nb = get(d,'numOrder');

Na = get(d,'denOrder');

% Get frequency specs, they have been prenormalized
Fc = get(d,'Fc');

h = fdesign.lowpass('Nb,Na,F3dB', Nb,Na,Fc);
Hd = design(h);


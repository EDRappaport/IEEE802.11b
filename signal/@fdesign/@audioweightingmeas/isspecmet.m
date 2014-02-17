function  b = isspecmet(this, hfdesign)
%ISSPECMET   True if the object is specmet.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/10/16 06:41:34 $

if nargin < 2
    hfdesign = get(this, 'Specification');
end

% Get the specifications from the FDesign object. 
% Mask magnitudes, frequencies, and magnitude measurements are row vectors.
% Measurements are done with the interpolated masks to have better resolution.
minfo = measureinfo(hfdesign);
b = ~any((this.MagnitudesInterp > minfo.Ainterp(1,:)) | (this.MagnitudesInterp < minfo.Ainterp(2,:))); 
end


% [EOF]

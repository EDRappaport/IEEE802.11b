function b = isspecmet(this, hfdesign)
%ISSPECMET   True if the object is specmet.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:24:26 $

if nargin < 2
    hfdesign = get(this, 'Specification');
end

% Get the specifications from the FDesign object.
specs = measureinfo(hfdesign);

% Return true if the measured Apass is less than or equal to the specificed
% and if the measured Astop is greater than or eual to the specified.
if (isempty(specs.Apass) || this.Apass <= specs.Apass)
    b = true;
else
    b = false;
end

% [EOF]

function b = isspecmet(this, hfdesign)
%ISSPECMET   True if the object is specmet.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:23:09 $

if nargin < 2
    hfdesign = get(this, 'Specification');
end

specs = measureinfo(hfdesign);

if ((isempty(specs.Apass1) || this.Apass1 <= specs.Apass1) && ...
    (isempty(specs.Astop)  || this.Astop  >= specs.Astop) && ...
    (isempty(specs.Apass2) || this.Apass2 <= specs.Apass2))
    b = true;
else
    b = false;
end

% [EOF]

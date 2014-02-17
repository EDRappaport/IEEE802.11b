function b = isspecmet(this, hfdesign)
%ISSPECMET   True if the object is specmet.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/10/16 06:41:41 $

if nargin < 2
    hfdesign = get(this, 'Specification');
end

minfo = measureinfo(hfdesign);

b = true;
n = length(this.Magnitudes);
if any(minfo.A(1:n)<this.Magnitudes)
    b = false;
end
if any(minfo.A(n+2:end)>this.Magnitudes)
    b = false;
end


% [EOF]

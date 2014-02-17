function b = isspecmet(this, Hd)
%ISSPECMET   True if the object is specmet.

%   Author(s): V. Pellissier
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2006/11/19 21:45:10 $

for i=1:length(Hd),
    m = measure(Hd(i));
    [F,A] = getmask(this,maskutils(this,1));

    b(i) = true;
    n = length(m.Magnitudes);
    if any(A(1:n)<m.Magnitudes)
        b(i) = false;
    end
    if any(A(n+2:end)>m.Magnitudes)
        b(i) = false;
    end
end

% [EOF]

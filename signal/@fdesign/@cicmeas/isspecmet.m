function b = isspecmet(this, hspecs)
%ISSPECMET   True if the object is specmet.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:23:32 $

if nargin < 2
    hspecs = get(this, 'Specification');
end

if this.Astop >= hspecs.Astop
    b = true;
else
    b = false;
end

% [EOF]

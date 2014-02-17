function out  = setcbands(hObj, out)
%SETCBANDS Private pre-set function

%   Author(s): J. Schickler
%   Copyright 1988-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:12:54 $

% Cache the old ConstrainedBands in case the set fails.
oldcb = get(hObj, 'ConstrainedBands');

set(hObj, 'privConstrainedBands', out);

out = [];

try
    filterType_listener(hObj);
catch ME
    
    % If the object failed to update properly reset the constrainedbands
    set(hObj, 'privConstrainedBands', oldcb);
    throw(ME);
end

% [EOF]

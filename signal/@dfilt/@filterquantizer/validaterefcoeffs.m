function validaterefcoeffs(~, prop, val)
%VALIDATEREFCOEFFS   

%   Author(s): V. Pellissier
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $  $Date: 2011/05/13 18:10:49 $

if ~(strcmpi(class(val), 'double') || strcmpi(class(val), 'single') ...
        || strcmpi(class(val), 'embedded.fi') ...
        || strncmpi(class(val), 'int', 3) || strncmpi(class(val), 'uint', 4)),
    error(message('signal:dfilt:filterquantizer:validaterefcoeffs:invalidDataType', prop, 'fi', 'double', 'int*', 'uint*'));
end

if issparse(val),
    error(message('signal:dfilt:filterquantizer:validaterefcoeffs:invalidSparse', prop));
end

% [EOF]

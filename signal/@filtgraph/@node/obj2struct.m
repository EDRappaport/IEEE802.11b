function s = obj2struct(this)
%OBJ2STRUCT <short description>

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/11/17 12:41:25 $

N = length(this);
for I = 1:N
    s(I) = get(this(I));
    s(I).block = obj2struct(this(I).block);
end

% [EOF]

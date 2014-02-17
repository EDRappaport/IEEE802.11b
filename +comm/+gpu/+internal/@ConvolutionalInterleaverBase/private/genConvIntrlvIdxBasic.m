function y = genConvIntrlvIdxBasic(base,offset,max)

%   Copyright 2011 The MathWorks, Inc.

y = base + offset;
% wrap around the bottom of the memory
if y < 1
    y = max + y;
end
end

function y = genConvIntrlvIdx(base,offset,delay,max)

%   Copyright 2011 The MathWorks, Inc.

y = base + offset - delay;
% wrap around the bottom of the memory
if y < 1
    y = max + y;
end
end

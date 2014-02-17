function  y = Gray_default_hard_8pskd(x1,x2) 
% Copyright 2011-2012 The MathWorks, Inc.
cx = uint8(x1);

if x2 == 4 
    y = bitget(cx,3);
elseif x2 == 2
    y = bitget(cx+2,3);
else
    y = bitget(cx+1,2);
end

y = double(y);
     
end


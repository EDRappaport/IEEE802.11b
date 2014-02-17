function  z = Gray_default_hard_4pskd(x,y) 
% Copyright 2011-2012 The MathWorks, Inc.
cx=uint8(x);

if y == 2
    z = bitshift(cx,-1);
else
    z = bitxor(bitget(cx,1),bitget(cx,2));
end


z = double(z);

% y = mod(fix(x1./x2),2);

end


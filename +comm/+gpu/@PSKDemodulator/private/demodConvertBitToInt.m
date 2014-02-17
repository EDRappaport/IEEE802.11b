function  y = demodConvertBitToInt(x1, x2) 
% Copyright 2011 The MathWorks, Inc.
y = mod(fix(x1./x2),2);
end

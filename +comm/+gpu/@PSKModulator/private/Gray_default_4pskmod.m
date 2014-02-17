function y = Gray_default_4pskmod(x)
% Copyright 2012 The MathWorks, Inc.
	if x == 0
		y = 0.923879532511287 + 0.382683432365090i;
	elseif x == 1
		y = -0.382683432365090 + 0.923879532511287i;
	elseif x == 2
		y = 0.382683432365090 - 0.923879532511287i;
	else
		y = -0.923879532511287 - 0.382683432365090i;	

end

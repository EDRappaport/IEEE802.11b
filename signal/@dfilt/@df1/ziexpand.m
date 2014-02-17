function zi = ziexpand(Hd,x,zi)
%ZIEXPAND Expand initial conditions for multiple channels when necessary
%   ZI = ZIEXPAND(Hd, X, ZI) 
%
%   This function is intended to only be used by SUPER_FILTER to expand initial
%   conditions. 
%
%   This should be a private method.   

%   Author: Thomas A. Bryan, R. Losada
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $  $Date: 2011/05/13 18:10:11 $


error(nargchk(3,3,nargin,'struct'));

[m,ndata] = size(x);
ndata = max(ndata,1);

if ~(isempty(zi) | any(size(zi.Numerator,2) == [ndata,1])),
	error(message('signal:dfilt:df1:ziexpand:InvalidStateDimensions'));
end

if ~(isempty(zi) | any(size(zi.Denominator,2) == [ndata,1])),
	error(message('signal:dfilt:df1:ziexpand:InvalidDenominatorDimensions'));
end


if size(zi.Numerator,2) == 1,
    zi.Numerator   = zi.Numerator(:,ones(1,ndata));
end

if size(zi.Denominator,2) == 1,
    zi.Denominator = zi.Denominator(:,ones(1,ndata));
end

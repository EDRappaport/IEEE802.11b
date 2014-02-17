function zi = ziexpand(Hd,x,zi)
%ZIEXPAND Expand initial conditions for multiple channels when necessary
%   ZI = ZIEXPAND(Hd, X, ZI) 
%
%   This function is intended to only be used by SUPER_FILTER to expand initial
%   conditions. 
%
%   This should be a private method.   

%   Author: R. Losada
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.1.4.2 $  $Date: 2010/12/06 00:06:11 $


error(nargchk(3,3,nargin,'struct'));

[m,ndata] = size(x);
ndata = max(ndata,1);

if size(zi,2) ~= ndata && size(zi,2) ~= 1,
	error(message('signal:dfilt:fftfir:ziexpand:InvalidDimensions'));
end

if size(zi,2) == 1,
	zi = zi(:,ones(1,ndata));
end

% Expand the fftcoeffs as well
bfft = Hd.fftcoeffs;
bfft = repmat(bfft(:,1),1,ndata);
Hd.fftcoeffs = bfft;


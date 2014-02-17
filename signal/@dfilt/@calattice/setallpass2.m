function coeffs = setallpass2(Hd,coeffs)
%SETALLPASS2 Overloaded set on the Allpass2 property
%
%   This should be a private method.
  
%   Author: V. Pellissier
%   Copyright 1999-2003 The MathWorks, Inc.
%   $Revision: 1.4.4.2 $  $Date: 2004/04/12 23:53:24 $

ncoeffs = Hd.ncoeffs;
oldlength=0;
if length(ncoeffs)==2, oldlength = ncoeffs(2); end
newlength = length(coeffs);
ncoeffs(2) = newlength;
Hd.ncoeffs = ncoeffs;

if newlength~=oldlength,
    reset(Hd);
end

set(Hd,'refAllpass2',coeffs);
quantizecoeffs(Hd);

% Hold an empty to not duplicate storage
coeffs = [];

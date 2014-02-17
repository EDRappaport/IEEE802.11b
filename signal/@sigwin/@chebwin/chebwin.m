function hWIN = chebwin(n, atten)
%CHEBWIN Construct a Chebyshev object
%
%   SIGWIN.CHEBWIN is not recommended.  Use <a href="matlab:help chebwin">chebwin</a> instead.
%
%   H = SIGWIN.CHEBWIN(N, S) constructs a Chebyshev window object with
%   length N and sidelobe attenuation S.  If N or S is not specified, they
%   default to 64 and 100 respectively.

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.chebwin;
hWIN.Name = 'Chebyshev';
createdynamicprops(hWIN, 'SidelobeAtten', 'double', 'Sidelobe Attenuation');

if nargin>0,
    hWIN.length = n;
end

if nargin>1,
    hWIN.SidelobeAtten = atten;
else
    hWIN.SidelobeAtten = 100;
end

% [EOF]

function hWIN = bartlett(n)
%BARTLETT Bartlett window.
%
%   SIGWIN.BARTLETT is not recommended.  Use <a href="matlab:help bartlett">bartlett</a> instead.
%
%   H = SIGWIN.BARTLETT(N) returns a N-point Bartlett window object H.
%
%   EXAMPLE:
%     N = 64; 
%     h = sigwin.bartlett(N); 
%     w = generate(h);
%     stem(w); title('64-point Bartlett Window');

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.bartlett;
hWIN.Name = 'Bartlett';

if nargin>0,
    hWIN.length = n;
end

% [EOF]

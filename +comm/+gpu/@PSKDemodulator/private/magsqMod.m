function r = magsqMod(a, b, x, variance)
% Copyright 2011 The MathWorks, Inc.
v = a - x;
w = b - x;
magsqv = (real(v).*real(v) + imag(v).*imag(v));
magsqw = (real(w).*real(w) + imag(w).*imag(w));
r = (magsqw - magsqv)/variance;
end

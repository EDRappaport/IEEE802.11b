function [y0, y1] = exactLLRCalculation(c0, c1, input, theVariance)
% Copyright 2011 The MathWorks, Inc.

v0 = c0 - input;
v1 = c1 - input;
msq0 = (real(v0).*real(v0) + imag(v0).*imag(v0))/theVariance;
msq1 = (real(v1).*real(v1) + imag(v1).*imag(v1))/theVariance;

y0 = exp( -1 * msq0);
y1 = exp( -1 * msq1);
end

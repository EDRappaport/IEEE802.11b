function y = Gray_default_exactLLR_8pskd(c0_11,c0_12,c0_13,c0_14,...
             c1_11,c1_12,c1_13,c1_14, input, theVariance)
% Copyright 2011-2012 The MathWorks, Inc.

v0_11 = c0_11 - input;
v0_12 = c0_12 - input;
v0_13 = c0_13 - input;
v0_14 = c0_14 - input;

v1_11 = c1_11 - input;
v1_12 = c1_12 - input;
v1_13 = c1_13 - input;
v1_14 = c1_14 - input;

msq0_11 = (real(v0_11).*real(v0_11) + imag(v0_11).*imag(v0_11))/theVariance;
msq0_12 = (real(v0_12).*real(v0_12) + imag(v0_12).*imag(v0_12))/theVariance;
msq0_13 = (real(v0_13).*real(v0_13) + imag(v0_13).*imag(v0_13))/theVariance;
msq0_14 = (real(v0_14).*real(v0_14) + imag(v0_14).*imag(v0_14))/theVariance;

msq1_11 = (real(v1_11).*real(v1_11) + imag(v1_11).*imag(v1_11))/theVariance;
msq1_12 = (real(v1_12).*real(v1_12) + imag(v1_12).*imag(v1_12))/theVariance;
msq1_13 = (real(v1_13).*real(v1_13) + imag(v1_13).*imag(v1_13))/theVariance;
msq1_14 = (real(v1_14).*real(v1_14) + imag(v1_14).*imag(v1_14))/theVariance;

y0_11 = exp( -1 * msq0_11);
y0_12 = exp( -1 * msq0_12);
y0_13 = exp( -1 * msq0_13);
y0_14 = exp( -1 * msq0_14);

y1_11 = exp( -1 * msq1_11);
y1_12 = exp( -1 * msq1_12);
y1_13 = exp( -1 * msq1_13);
y1_14 = exp( -1 * msq1_14);

y0_r1 = y0_11 + y0_12 + y0_13 + y0_14;
y1_r1 = y1_11 + y1_12 + y1_13 + y1_14;

y = log(y0_r1./y1_r1);

end

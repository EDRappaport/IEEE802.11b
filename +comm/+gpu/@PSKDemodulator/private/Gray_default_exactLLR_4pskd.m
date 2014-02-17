function [y_r1, y_r2] = Gray_default_exactLLR_4pskd(c0_a, c0_b, c0_c, c0_d, ...
                        c1_a, c1_b, c1_c, c1_d, input, theVariance)
% Copyright 2011-2012 The MathWorks, Inc.

v0_a = c0_a - input;
v0_b = c0_b - input;
v0_c = c0_c - input;
v0_d = c0_d - input;


v1_a = c1_a - input;
v1_b = c1_b - input;
v1_c = c1_c - input;
v1_d = c1_d - input;


msq0_a = (real(v0_a).*real(v0_a) + imag(v0_a).*imag(v0_a))/theVariance;
msq0_b = (real(v0_b).*real(v0_b) + imag(v0_b).*imag(v0_b))/theVariance;
msq0_c = (real(v0_c).*real(v0_c) + imag(v0_c).*imag(v0_c))/theVariance;
msq0_d = (real(v0_d).*real(v0_d) + imag(v0_d).*imag(v0_d))/theVariance;

msq1_a = (real(v1_a).*real(v1_a) + imag(v1_a).*imag(v1_a))/theVariance;
msq1_b = (real(v1_b).*real(v1_b) + imag(v1_b).*imag(v1_b))/theVariance;
msq1_c = (real(v1_c).*real(v1_c) + imag(v1_c).*imag(v1_c))/theVariance;
msq1_d = (real(v1_d).*real(v1_d) + imag(v1_d).*imag(v1_d))/theVariance;


y0_a = exp( -1 * msq0_a);
y0_b = exp( -1 * msq0_b);
y0_c = exp( -1 * msq0_c);
y0_d = exp( -1 * msq0_d);

y1_a = exp( -1 * msq1_a);
y1_b = exp( -1 * msq1_b);
y1_c = exp( -1 * msq1_c);
y1_d = exp( -1 * msq1_d);


y0_r1 = y0_a + y0_b;
y0_r2 = y0_c + y0_d;

y1_r1 = y1_a + y1_b;
y1_r2 = y1_c + y1_d;

y_r1 = log(y0_r1./y1_r1);
y_r2 = log(y0_r2./y1_r2);

end
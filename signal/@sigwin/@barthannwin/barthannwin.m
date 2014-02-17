function hWIN = barthannwin(n)
%BARTHANNWIN Modified Bartlett-Hanning window. 
%
%   SIGWIN.BARTHANNWIN is not recommended.  Use <a href="matlab:help barthannwin">barthannwin</a> instead.
%
%   H = SIGWIN.BARTHANNWIN(N) returns an N-point Modified Bartlett-Hanning
%   window object H.
%
%   EXAMPLE:
%      N = 64; 
%      h = sigwin.barthannwin(N);
%      w = generate(h);
%      stem(w); title('64-point Modified Bartlett-Hanning window');

%   Reference:
%     [1] Yeong Ho Ha and John A. Pearce, A New Window and Comparison
%         to Standard Windows, IEEE Transactions on Acoustics, Speech,
%         and Signal Processing, Vol. 37, No. 2, February 1999

%   Author(s): V.Pellissier
%   Copyright 1988-2012 The MathWorks, Inc.

hWIN = sigwin.barthannwin;
hWIN.Name = 'Bartlett-Hanning';
if nargin>0,
    hWIN.length = n;
end

% [EOF]

%BARTHANNWIN  修正 Bartlett-Hanning ウィンドウ
%
%   H = SIGWIN.BARTHANNWIN(N) は、N 点の修正 Bartlett-Hanning ウィンドウ
%   オブジェクト H を返します。
%
%   例:
%      N = 64;
%      h = sigwin.barthannwin(N);
%      w = generate(h);
%      stem(w); title('64-point Modified Bartlett-Hanning window');
%
%   参考 SIGWIN.


%   Copyright 1988-2008 The MathWorks, Inc.

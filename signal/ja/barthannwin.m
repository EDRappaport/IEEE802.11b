%BARTHANNWIN  修正 Bartlett-Hanning ウィンドウ
%
%   BARTHANNWIN(N) は、列ベクトルに N 点の修正 Bartlett-Hanning ウィンドウ
%   を返します。
%
%   例:
%      N = 64;
%      w = barthannwin(N);
%      plot(w); title('64-point Modified Bartlett-Hanning window');
%
%   参考 BARTLETT, BLACKMANHARRIS, BOHMANWIN, FLATTOPWIN,
%        NUTTALLWIN, PARZENWIN, RECTWIN, TRIANG, WINDOW.


%   Copyright 1988-2007 The MathWorks, Inc.

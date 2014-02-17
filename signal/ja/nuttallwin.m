%NUTTALLWIN  Nuttall の定義の最小 4-項 Blackman-Harris ウィンドウを定義
%
%   NUTTALLWIN(N) は、Albert H. Nuttal の論文に従う係数をもつ N-点修正最小 
%   4-項 Blackman-Harris ウィンドウを返します。
%
%   例:
%      N = 32;
%      w = nuttallwin(N);
%      plot(w); title('32-point Nuttall window');
%
%   参考 BARTHANNWIN, BARTLETT, BLACKMANHARRIS, BOHMANWIN,
%        FLATTOPWIN, PARZENWIN, RECTWIN, TRIANG, WINDOW.


%   Copyright 1988-2007 The MathWorks, Inc.

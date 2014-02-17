%GAUSSWIN  Gaussian ウィンドウ
%
%   GAUSSWIN(N) は、N-点の Gaussian ウィンドウを返します。
%
%   GAUSSWIN(N, ALPHA) は、ALPHA 値付きの N 点 Gaussian ウィンドウを
%   返します。ALPHA は、標準偏差の逆数として定義され、フーリエ変換の幅の
%   基準です。ALPHA が増加するにつれて、ウィンドウの幅は減少します。
%   省略された場合、ALPHA は、2.5 です。
%
%   例:
%      N = 32;
%      wvtool(gausswin(N));
%
%
%   参考 CHEBWIN, KAISER, TUKEYWIN, WINDOW.


%   Copyright 1988-2007 The MathWorks, Inc.

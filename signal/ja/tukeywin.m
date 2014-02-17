%TUKEYWIN  Tukey ウィンドウ
%
%   TUKEYWIN(N) は、N 点の Tukey ウィンドウを列ベクトルに返します。
%
%   W = TUKEYWIN(N,R) は、N 点の Tukey ウィンドウを列ベクトルに返します。
%   Tukey ウィンドウは、余弦のテーパウィンドウとしても知られています。
%   R パラメータは、一定区間におけるテーパの比率を指定します。この比は、
%   1 (すなわち、0 < R < 1) に正規化されています。省略した場合、R は 
%   0.500 に設定されます。
%
%   注意: R の値が極端な場合、Tukey ウィンドウは、他の共通のウィンドウに
%   退化することに注意してください。このため、R = 1 の場合、これは Hanning 
%   ウィンドウと等価になります。逆に、R = 0 にすると、Tukey ウィンドウは 
%   boxcar ウィンドウと等価です。
%
%   例:
%      N = 64;
%      w = tukeywin(N,0.5);
%      plot(w); title('64-point Tukey window, Ratio = 0.5');
%
%   参考 CHEBWIN, GAUSSWIN, KAISER, WINDOW.


%   Copyright 1988-2007 The MathWorks, Inc.

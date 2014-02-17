%ELLIPORD  楕円フィルタの次数推定
%
%   [N, Wp] = ELLIPORD(Wp, Ws, Rp, Rs) は、通過帯域の変動が Rp dB 以下で、
%   遮断帯域に少なくとも Rs dB の減衰をもつ最小次数の楕円フィルタの次数 
%   N を返します。通過帯域 Wp、遮断帯域 Ws は、0 から 1 までの正規化された
%   値です。ここで、1 はπラジアン/サンプルに対応します)。たとえば、つぎの
%   ようになります。
%       Lowpass:    Wp = .1,      Ws = .2
%       Highpass:   Wp = .2,      Ws = .1
%       Bandpass:   Wp = [.2 .7], Ws = [.1 .8]
%       Bandstop:   Wp = [.1 .8], Ws = [.2 .7]
%   ELLIPORD は、仕様を満足する楕円固有振動数 Wp も返します。
%
%   [N, Wp] = ELLIPORD(Wp, Ws, Rp, Rs, 's') は、アナログフィルタを設計
%   します。この場合、Wpと Ws の周波数はラジアン/秒単位です。
%
%   注意:Rs が Rp に比べてかなり大きい場合や、Wp と Ws がかなり近い値の場合、
%   推定された次数は、数値精度の限界のため無限になります。
%
%   参考 ELLIP, BUTTORD, CHEB1ORD, CHEB2ORD.


%   Copyright 1988-2007 The MathWorks, Inc.

%CHEB1ORD  チェビシェフ I 型フィルタの次数選択
%
%   [N, Wp] = CHEB1ORD(Wp, Ws, Rp, Rs) は、通過帯域の変動が Rp dB 以下で、
%   遮断帯域に少なくとも Rs dB の減衰をもつデジタルチェビシェフ I 型フィルタ
%   の最小次数 N を返します。通過帯域 Wp、遮断帯域 Ws は、0 から 1 までの
%   正規化された値です。ここで、1 はπラジアン/サンプルに対応します)。
%   たとえば、つぎのようになります。
%       Lowpass:    Wp = .1,      Ws = .2
%       Highpass:   Wp = .2,      Ws = .1
%       Bandpass:   Wp = [.2 .7], Ws = [.1 .8]
%       Bandstop:   Wp = [.1 .8], Ws = [.2 .7]
%   CHEB1ORD は、仕様を満足する CHEBY1 で使用するチェビシェフ固有振動数 
%   Wp も返します。
%
%   [N, Wp] = CHEB1ORD(Wp, Ws, Rp, Rs, 's') は、アナログフィルタを設計します。
%   この場合、Wp と Ws の周波数はラジアン/秒単位です。
%
%   参考 CHEBY1, CHEB2ORD, BUTTORD, ELLIPORD.


%   Copyright 1988-2007 The MathWorks, Inc.

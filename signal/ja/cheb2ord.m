%CHEB2ORD  チェビシェフ II 型フィルタの次数選択
%
%   [N, Ws] = CHEB2ORD(Wp, Ws, Rp, Rs) は、通過帯域で Rp dB 以下の減衰、
%   遮断帯域で、Rs dB 以上の減衰をもつデジタルチェビシェフ II 型フィルタの
%   最小次数 N を返します。通過帯域 Wp、遮断帯域 Ws は、0 から 1 までの
%   正規化された値です。ここで、1 はπラジアン/サンプルに対応します)。
%   たとえば、つぎのようになります。
%       Lowpass:    Wp = .1,      Ws = .2
%       Highpass:   Wp = .2,      Ws = .1
%       Bandpass:   Wp = [.2 .7], Ws = [.1 .8]
%       Bandstop:   Wp = [.1 .8], Ws = [.2 .7]
%   CHEBY2 を組み合わせて使用することにより、CHEB2ORD は、仕様を満足する
%   チェビシェフ固有周波数 Wst を返します。
%
%   [N, Ws] = CHEB2ORD(Wp, Ws, Rp, Rs, 's') は、アナログフィルタを設計します。
%   この場合、Wp と Ws の周波数はラジアン/秒です。
%
%   参考 CHEBY2, CHEB1ORD, BUTTORD, ELLIPORD.


%   Copyright 1988-2007 The MathWorks, Inc.

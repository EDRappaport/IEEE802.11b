%BUTTORD  バタワースフィルタの次数推定
%
%   [N, Wn] = BUTTORD(Wp, Ws, Rp, Rs) は、通過帯域の損失が Rp dB 以下で、
%   遮断帯域に少なくとも Rs dB の減衰をもつ、デジタルバタワースフィルタの
%   最小次数 N を返します。通過帯域 Wp、遮断帯域 Ws は、0 から 1 までの
%   正規化された値です。ここで、1 はπラジアン/サンプルに対応します)。
%   たとえば、つぎのようになります。
%       Lowpass:    Wp = .1,      Ws = .2
%       Highpass:   Wp = .2,      Ws = .1
%       Bandpass:   Wp = [.2 .7], Ws = [.1 .8]
%       Bandstop:   Wp = [.1 .8], Ws = [.2 .7]
%   BUTTORD は、仕様を満足するために、関数 BUTTER を使った、バタワース
%   カットオフ周波数 (あるいは、"3 dB 周波数") Wn を返します。
%
%   [N, Wn] = BUTTORD(Wp, Ws, Rp, Rs, 's') は、アナログフィルタを設計
%   します。この場合、Wp と Ws の周波数はラジアン/秒単位です。
%
%   また、Rp が 3 dB の場合、関数 BUTTER の Wn と関数 BUTTORD の Wp は
%   等価になります。
%
%   参考 BUTTER, CHEB1ORD, CHEB2ORD, ELLIPORD.


%   Copyright 1988-2007 The MathWorks, Inc.

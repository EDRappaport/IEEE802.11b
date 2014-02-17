%MODULATE  通信シミュレーションのための信号の変調
%
%   Y = MODULATE(X,Fc,Fs,METHOD,OPT) は、つぎの METHOD のオプションである
%   変調方法いずれか 1 つを使って、搬送波周波数 Fc とサンプリング周波数 
%   Fs をもつメッセージ信号 X を変調します。OPT は、選択する変調方式に依存し、
%   場合によっては余分なパラメータです。
%
%   Fs は、Fs > 2*Fc + BW を満足する必要があります。ここで、BW は変調された
%   信号の帯域幅です。
%
%    METHOD              変調方法
%    'am'         振幅変調、両側波帯、抑圧搬送波。
%    'amdsb-sc'   OPT を使用しません。
%    'amdsb-tc'   振幅変調、両側波帯、伝送搬送波。
%                 OPT は、搬送コサイン波を乗じる前に X から減算するスカラ値です。
%                 デフォルトは、min(min(x)) です。そのため、オフセットメッセージ
%                 信号が正で、かつ、最小値が 0 になります。
%    'amssb'      振幅変調、片側波帯。
%                 OPT を使用しません。
%    'fm'         周波数変調。
%                 OPT は、周波数変調 kf の定数を指定するスカラです。Fc Hz の
%                 最大周波数に対するデフォルト値は、
%                 kf = (Fc/Fs)*2*pi/max(max(abs(X))) になります。
%    'pm'         位相変調。
%                 OPT は、位相変調 kp の定数を指定するスカラです。最大位相 
%                 ±πラジアンに対するデフォルト値は、
%                 kp = pi/max(max(abs(x))) になります。
%    'pwm'        パルス幅変調。
%                 OPT を 'centered' に設定すると、左端に立ち上がっている
%                 パルスは各搬送周期の中心に設定されます。
%    'ppm'        パルス位置変調。
%                 OPT は、0 から 1 の間で、搬送波の周期を単位に分割された
%                 各々のパルスの幅を指定しています。OPT のデフォルト値は 0.1 です。
%    'qam'        直交振幅変調。
%                 OPT は、X を直交振幅変調したものと同じサイズの行列です。
%
%   X が配列の場合、MODULATE は、各列を変調します。
%
%   [Y,T] = MODULATE(...) は、Y と同じ長さの時間ベクトルを返します。
%
%   参考 Signal Processing Toolbox の DEMOD, VCO, Communications Toolbox の 
%        PAMDEMOD, QAMDEMOD, GENQAMDEMOD, FSKDEMOD, PSMDEMOD, MSKDEMOD.


%   Copyright 1988-2007 The MathWorks, Inc.

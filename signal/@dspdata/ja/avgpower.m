%AVGPOWER  平均パワー
%
%   AVGPOWER(H) は、H に与えられたそのような信号のパワースペクトル密度 (PSD) の
%   積分の長方形近似により、信号の平均パワーを計算します。H の PSD データが行列
%   の場合、処理は、各列で行われます。H は DSP データ (<a href="matlab:help dspdata">dspdata</a>) オブジェクトです。
%
%   H の SpectrumType プロパティの値に依存し、AVGPOWER は、片側、または両側
%   スペクトルのいずれかの範囲で平均パワーの総和を計算します。片側スペクトルに
%   対して、その演算は、偶数の周波数点に対して [0,pi] の範囲、奇数の周波数点に
%   対して [0,pi) の範囲で行われます。両側スペクトルに対して、計算は [0,2pi) の
%   範囲で行われます。
%
%   AVGPOWER(H,FREQRANGE) は、平均パワーを計測するための周波数範囲を指定します。
%   FREQRANGE は、パワーを計測する範囲の 2 点の周波数を指定する実数値の 2 要素
%   ベクトルです。
%
%   注意:周波数範囲の値が明確にオブジェクト H に格納された値と一致しない場合、
%   次に近い値が使われます。さらに、2 要素の周波数範囲ベクトルの 2 番目の値は
%   排除されますが、1 番目の要素は、平均パワーの計算に含まれます。
%
%   例
%      0.2 Hz の周波数成分をもつ正弦波の平均パワーを計算します。(1 周期の) 
%      平均パワーは A^2/2 = 8 で与えら得ます。ここで、A は正弦波の振幅です。
%
%      f = .2; Fs = 1;
%      n = 0:999;
%      x = 4*sin(2*pi*f/Fs*n);
%
%      h = spectrum.periodogram('rectangular');     % ピリオドグラムのスペクトル推定器
%      hopts = psdopts(h);                          % デフォルトのオプション
%      set(hopts,'NFFT',2^12,'Fs',Fs,'SpectrumType','twosided');
%      hpsd = psd(h,x,hopts);                       % PSD データのプロット
%      pwr = avgpower(hpsd)
%
%      % 0.1 と 0.3 の範囲の多くのパワーに注目して片側 PSD を計算してプロットします。
%      % そのため、その範囲のパワーを計算することは、すべてではありませんが、多くの
%      % 信号のパワーを返す必要があります。これは、スペクトルリーケージのためです。
%
%      hopts.SpectrumType='onesided';
%      hpsd = psd(h,x,hopts);
%      plot(hpsd);
%      pwr = avgpower(hpsd,[.1 .3])
%
%   参考 DSPDATA, SPECTRUM.


%   Copyright 1988-2007 The MathWorks, Inc.

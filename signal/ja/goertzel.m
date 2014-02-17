%GOERTZEL  2 次 Goertzel アルゴリズム
%
%   GOERTZEL(X,INDVEC) は、2 次の Goertzel アルゴリズムを使用して、ベクトル 
%   INDVEC に含まれるインデックスで、X の離散フーリエ変換 (DFT) を計算します。
%   インデックスは、1 からN までの整数値である必要があります。ここで、N は、
%   最初の非シングルトン次元の長さです。空、または省略した場合、I は、1:N で
%   あると仮定します。
%
%   GOERTZEL(X,[],DIM) または GOERTZEL(X,INDVEC,DIM) は、次元 DIM に従って 
%   DFT を計算します。
%
%   一般に、可能なあらゆる DFT インデックスを計算する場合、GOERTZEL は、
%   FFT より遅くなります。しかし、X が長いベクトルで、DFT の場合、最も
%   有効です。インデックス 1:length(X) は、周波数区間 [0, 2*pi) ラジアンに
%   対応します。
%
%   例:
%   % 10 kHz の成分をもつ次のノイズを含む余弦に、1.24 kHz と 1.26 kHz の
%   % 成分を関連付けます。
%      Fs = 32e3;   t = 0:1/Fs:2.96;
%      x  = cos(2*pi*t*10e3)+cos(2*pi*t*1.24e3)+cos(2*pi*t*1.26e3)...
%           + randn(size(t));
%
%      N = (length(x)+1)/2;
%      f = (Fs/2)/N*(0:N-1);              % 周波数ベクトルを生成
%      indxs = find(f>1.2e3 & f<1.3e3);   % 対象の周波数を求める;
%      X = goertzel(x,indxs);
%
%      hms = dspdata.msspectrum((abs(X)/length(X)).^2,f(indxs),'Fs',Fs);
%      plot(hms);                         % 平均二乗スペクトルをプロット
%
%   参考 FFT, FFT2.


%   Copyright 1988-2007 The MathWorks, Inc.

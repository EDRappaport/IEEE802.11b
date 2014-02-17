%SPECTRUM  スペクトル推定
%
%   H = SPECTRUM.<ESTIMATOR> は、ESTIMATOR で指定したタイプのスペクトル推定器を 
% H に返します。
%
%   推定器には 3 つのタイプがあります:パワースペクトル密度 (PSD)、平均二乗スペク
%トル (MSS)、擬似スペクトル。これらの 3 つのタイプのそれぞれの <ESTIMATOR> に
%対する有効な値を以下にリストします。特定のスペクトル推定器のヘルプを得るに
%は、"help spectrum.<ESTIMATOR>" とタイプしてください。たとえば、"help 
%spectrum.welch"。
%
%   ----------------------------
%   パワースペクトル密度 (PSD)
%   ----------------------------
%   <a href="matlab:help spectrum.burg">burg</a> - Burg
%   <a href="matlab:help spectrum.periodogram">periodogram</a> - ピリオドグラム
%   
%   <a href="matlab:help spectrum.cov">cov</a>  - 共分散
%   <a href="matlab:help spectrum.welch">welch</a>       - Welch
%   <a href="matlab:help spectrum.mcov">mcov</a> - 修正共分散
%   <a href="matlab:help spectrum.yulear">yulear</a>      - Yule-Walker AR
%   <a href="matlab:help spectrum.mtm">mtm</a>  - Thomson マルチテーパ法 (MTM)
%
%   PSD を計算するには、上記の推定器の 1 つを作成し、データと共に以下の関数の 
%   1 つにそれを渡さなければなりません。
%
%   <a href="matlab:help spectrum/psd">psd</a>     - PSD を計算
%   <a href="matlab:help spectrum/psdopts">psdopts</a> - PSD を計算するためのオプション
%
%   --------------------------
%   平均二乗スペクトル (MSS)
%   --------------------------
%   <a href="matlab:help spectrum.periodogram">periodogram</a> - ピリオドグラム
%   <a href="matlab:help spectrum.welch">welch</a>       - Welch
%
%   MSS を計算するには、上記の推定器の 1 つを作成し、データと共に以下の関数の 
%   1 つにそれを渡さなければなりません。
%
%   <a href="matlab:help spectrum/msspectrum">msspectrum</a>     - 平均二乗スペクトル (MSS) を計算
%   <a href="matlab:help spectrum/msspectrumopts">msspectrumopts</a> - MSS を計算するためのオプション
%
%   ---------------
%   擬似スペクトル
%   ---------------
%   <a href="matlab:help spectrum.eigenvector">eigenvector</a> - 固有ベクトル
%   <a href="matlab:help spectrum.music">music</a>       - 多重信号分類 (MUSIC)
%
%   擬似スペクトルを計算するには、上記の推定器の 1 つを作成し、データと共に
%   以下の関数の 1 つにそれを渡さなければなりません
%
%   <a href="matlab:help spectrum/powerest">powerest</a>           - 正弦波のパワーと周波数を計算
%   <a href="matlab:help spectrum/pseudospectrum">pseudospectrum</a>     - 擬似スペクトルを計算
%   <a href="matlab:help spectrum/pseudospectrumopts.">pseudospectrumopts</a> - 擬似スペクトルを計算するためのオプション
%
%   注意:SPECTRUM の関数の形式は旧式です。まだ機能しますが、将来削除される
%   可能性があります。SPECTRUM は、SPECTRUM オブジェクトや、 PWELCH, TFESTIMATE, 
%   MSCOHERE のような他の関数に置き換えられています。
%
%   例:200Hz の余弦波とノイズを含む信号のスペクトル解析
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t));
%      h = spectrum.welch;           % Welch スペクトル推定器の作成
%
%      Hpsd = psd(h,x,'Fs',Fs);             % PSD の計算
%      plot(Hpsd)                           % PSD のプロット
%
%   詳細については、<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\spectralanalysisobjsdemo.html'])">Getting Started デモ</a> を参照してください。
%
%   <a href="matlab:help signal">Signal Processing Toolbox の目次</a>
%
%   参考 DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.

%FREQRESPEST  フィルタリングによる周波数応答の推定
%
%   [H,W] = FREQRESPEST(Hd,L) は、フィルタを通して一様分布するランダムな
%   周波数をもつ正弦波から作られた入力データを実行し、出力データと入力データ間
%   の比を形成することで、フィルタ Hd の周波数応答の推定を計算します。
%   これは、特に固定小数点フィルタで役立ちます。周波数応答の推定は、量子化
%   された係数のみを使うことで得られる周波数応答に近くなりますが、固定小数点
%   フィルタの加算器/乗算器を無視すると、フィルタの固定小数点の実装は、同じ 
%   (量子化された) 係数をもつ浮動小数点の実装とより一致します。
%
%   L は推定を計算するために使われる試行回数です。指定されない場合、L は
%   デフォルトで 10 です。一般的に、より多い試行を使うと、推定を計算する
%   ために必要となる長い時間を犠牲にして、より精度の高い推定が得られます。
%
%   H は複素数の周波数応答の推定です。W は推定された H における周波数
%   ベクトルです。
%
%   [H,W] = FREQRESPEST(Hd,L,P1,V1,P2,V2,...) は、パラメータ-値の組み合わせで
%   オプションパラメータを指定します。有効な組み合わせはつぎの通りです:
%         パラメータ               デフォルト     説明/有効な値
%    ---------------------  -----------  ----------------------------------
%    'NFFT'                 512          FFT 点数
%    'NormalizedFrequency'  true         {true,false}
%    'Fs'                   'Normalized' サンプリング周波数 'NormalizedFrequency' 
%                                        が false のときのみ使用
%    'SpectrumRange'        'Half'       {'Half','Whole'}
%    'CenterDC'             false        {true,false}
%
%   FREQRESPEST(Hd,L,OPTS) は、指定するパラメータ-値の組み合わせの lieu 内の
%   オプションのパラメータを指定するために、オプションのオブジェクトを使用します。
%   OPTS オブジェクトは、OPTS = FREQRESPOPTS(Hd) で作成できます。設定は、
%   FREQRESPEST を呼び出す前に OPTS で変更できます。たとえば、set(OPTS,'Fs',48e3);
%
%   FREQRESPEST の別の使用は、FREQZ による計算に影響を及ぼす重要な丸め誤差のない
%   伝達関数形式に変換できない倍精度浮動小数点フィルタの周波数応答を計算すること
%   です。例は、特に長いフィルタであるいくつかの状態空間、またはラティスフィルタ
%   です。
%
%   % 例 1.内部のフィルタが完全精度 (full precision) に設定されている固定小数点 
%   % FIR フィルタの周波数応答の推定を計算します。 
%   Hd = design(fdesign.lowpass(.4,.5,1,60),'equiripple');
%   Hd.Arithmetic = 'fixed';
%   [H,w] = freqrespest(Hd); % これは FREQZ と同じである必要があります
%
%   % 例 2.例 1 と同じ固定小数点 FIR フィルタに対する周波数応答を計算しますが、
%   % 加算器/乗算器の精度を指定します。
%   Hd.FilterInternals = 'SpecifyPrecision';
%   Hd.OutputWordLength=16; Hd.OutputFracLength=15;
%   Hd.ProductWordLength=16; Hd.ProductFracLength=15;
%   Hd.AccumWordLength=16; Hd.AccumFracLength=15;
%   [H,w] = freqrespest(Hd,2);
%   [H2,w2] = freqz(Hd,512);
%   plot(w/pi,20*log10(abs([H,H2])))
%   legend('Frequency response estimate by filtering',...
%       'Frequency response computed by quantizing coefficients only');
%   xlabel('Normalized Frequency (\times\pi rad/sample)')
%   ylabel('Magnitude (dB)')
%
%   % 例 3.状態空間フィルタの周波数応答を推定します。
%   Fs = 315000;
%   Wp = [320 3800]/(Fs/2);
%   Ws = [50 19000]/(Fs/2);
%   Rp=0.15; Rs=60;
%   [n,Wn]=cheb1ord(Wp,Ws,Rp,Rs);
%   [a,b,c,d] = cheby1(n,Rp,Wn);
%   Hd = dfilt.statespace(a,b,c,d);
%   freqrespest(Hd,1,'NFFT',8192); % freqz(Hd,8192); と比較
%
%   参考 dfilt/freqrespopts, dfilt/noisepsd,  dfilt/scale, dfilt/functions.


%   Copyright 2006-2007 The MathWorks, Inc.

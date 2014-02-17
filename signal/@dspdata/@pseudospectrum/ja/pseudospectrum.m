%PSEUDOSPECTRUM  擬似スペクトル
%
%   H = DSPDATA.PSEUDOSPECTRUM(DATA) は、DATA に設定されたプロパティの
%   設定で、オブジェクト H のインスタンスを作成します。DATA はパワーを
%   表すため、実数で正の値を含んでいなければなりません。DATA は、ベクトル
%   または行列になります。ここで、各列は、独立試行を表します。対応する
%   周波数ベクトルは、[0, pi] の範囲内で自動的に生成されます。Fs は、
%   デフォルトで "Normalized" です。
%
%   H = DSPDATA.PSEUDOSPECTRUM(DATA,FREQUENCIES) は、オブジェクト内の周波数
%   ベクトルを FREQUENCIES に設定します。ベクトル FREQUENCIES の長さは、
%   DATA の列の長さと等しくなければなりません。
%
%   H = DSPDATA.PSEUDOSPECTRUM(...,'Fs',Fs) は、サンプリング周波数を Fs に
%   設定します。FREQUENCIES が指定されない場合、周波数ベクトルは、デフォルトで 
%   [0,Fs/2] です。詳細は、以下の注意を参照してください。
%
%   H = DSPDATA.PSEUDOSPECTRUM(...,'SpectrumRange',SPECTRUMRANGE) は、
%   SpectrumRange プロパティを SPECTRUMRANGE で指定される文字列 'half' 
%   または 'whole' のいずれかに設定します。
%
%   H = DSPDATA.PSEUDOSPECTRUM(...,'CenterDC',true) は、データの DC 値を
%   ベクトルの中央にすることを示します。CenterDC を true に設定すると、
%   自動的に 'SpectrumRange' が 'whole' に設定されます。
%
%   周波数ベクトルが指定されない場合、デフォルトの周波数ベクトルは、
%   'CenterDC' の設定に従って生成されます。周波数ベクトルが指定された場合、
%   'CenterDC' は、指定した周波数ベクトル (とデータ) と一致するように
%   設定する必要があります。このプロパティを修正するには、<a href="matlab:help dspdata/centerdc">centerdc</a> メソッドを
%   使用してください。
%
%   注意： 指定したスペクトルデータが "半分の" ナイキスト区間で計算され、
%   対応する周波数ベクトルを指定していない場合、デフォルトの周波数ベクトルは、
%   "全体の" FFT 内の点数が偶数であるものと仮定します。さらに、"全体の" 
%   スペクトルに変換するためのプロットオプションは、オリジナルの "全体の" 
%   FFT 長が偶数であるものと仮定します。
%
%   例: 固有値解析を使って、二つの周波数要素でノイズ正弦信号の擬似スペクトルを
%            推定します。ここで、PSEUDOSPECTRUM データオブジェクトの結果を保存し、
%            プロットします。
%
%        Fs = 32e3;   t  = 0:1/Fs:2.96;
%        x = cos(2*pi*t*1.24e3) + cos(2*pi*t*10e3) + randn(size(t));
%        P = pmusic(x,4);
%        hps = dspdata.pseudospectrum(P,'Fs',Fs); % データオブジェクトの作成
%        plot(hps);                          % pseudospectrumのプロット
%
%   参考 DSPDATA, SPECTRUM.


%   Copyright 1988-2008 The MathWorks, Inc.
